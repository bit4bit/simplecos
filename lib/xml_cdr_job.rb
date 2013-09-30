# Copyright (C) 2012 Bit4Bit <bit4bit@riseup.net>
#
#
# This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'uri'
require 'zlib'
require 'csv'
require 'fileutils'

class XmlCdrJob
  SEGUNDOS_COBRO_BASE = 60

  attr_accessor  :xml_cdr, :prefix_dir
  def initialize(xml_cdr, prefix_dir ='')
    self.xml_cdr = xml_cdr
    self.prefix_dir = prefix_dir
  end
  
  def perform
    case self.xml_cdr
    when String
      cdr = (Hash.from_xml self.xml_cdr)['cdr']
    when Hash
      cdr = self.xml_cdr['cdr']
    end
    
    begin
      Rails.logger.debug(cdr)
      nibble_account = URI.decode(cdr['variables']['nibble_account'])
      create_directories(nibble_account, cdr)
      clean_days_of_month_past(nibble_account, cdr)
      cdr_day(nibble_account, cdr)
      cdr_week(nibble_account, cdr)
      cdr_month(nibble_account, cdr)
    rescue Exception => e
      Rails.logger.error(e.message)
      Rails.logger.error(e.backtrace)
    end
  end
  

  private
  def clean_days_of_month_past(account, cdr)
    cdr_file = Rails.root.join(cdr_dir, account.to_s, time_cdr(cdr).to_s(:cdr_month), 'month_' + time_cdr(cdr).to_s(:cdr_month) + '.csv.gz')
    unless File.exists?(cdr_file)
      FileUtils.rm  Dir.glob(Rails.root.join(cdr_dir, account.to_s, time_cdr(cdr).to_s(:cdr_month), 'day_*.csv.gz'))
      FileUtils.rm  Dir.glob(Rails.root.join(cdr_dir, account.to_s, time_cdr(cdr).to_s(:cdr_month), 'week_*.csv.gz'))
      return true
    end
    return false
  end
  
  def create_directories(account, cdr)
    begin Dir.mkdir(Rails.root.join(cdr_dir)) ;rescue; end
    begin Dir.mkdir(Rails.root.join(cdr_dir, account)) ;rescue; end
    begin Dir.mkdir(Rails.root.join(cdr_dir, account, time_cdr(cdr).to_s(:cdr_month))) ;rescue; end
  end
  
  def time_cdr(cdr)
    Time.at(URI.decode(cdr['variables']['start_epoch']).to_d)
  end
  
  def cdr_to_save(account, cdr)
    if cdr['variables'].nil?
      cdr['variables'] = {}
    end
    cdr['variables'].merge({'remote_media_ip' => '', 'billsec' => '0'})

    {
      :account_id => account.to_i,
      :sip_user => URI.decode(cdr['variables']['sip_from_user'].to_s),
      :signaling_ip => URI.decode(cdr['variables']['sip_network_ip'].to_s),
      :remote_media_ip => URI.decode(cdr['variables']['remote_media_ip'].to_s),
      :call_time => Time.at(URI.decode(cdr['variables']['start_epoch']).to_d).to_s,
      :duration => URI.decode(cdr['variables']['billsec'].to_s).to_i,
      :destination_number => URI.decode(cdr['callflow']['caller_profile']['destination_number'].to_s),
      :ani => URI.decode(cdr['callflow']['caller_profile']['ani'].to_s),
      :total_amount => calculate_total_amount(cdr)
    }
  end

  def cdr_dir
    self.prefix_dir.to_s + 'cdr'
  end
  
  def cdr_save(account, cdr, cdr_file)
    create_header(cdr_file, cdr_to_save(account, cdr).keys)
    gz = Zlib::GzipWriter.new(File.open(cdr_file, 'ab'))
    gz.write CSV.generate_line(cdr_to_save(account, cdr).values)
    gz.close
  end
  
  def calculate_total_amount(cdr)
    bill_rate = 0
    bill_minimum = 0
    begin
      cash_plan = ClientCashPlan.find(URI.decode(cdr['variables']['simplecos_client_cash_plan'].to_s).to_i)
      bill_rate = cash_plan.bill_rate
      bill_minimum = cash_plan.bill_minimum
    rescue ActiveRecord::RecordNotFound
      cash_plan = PublicCashPlan.find(URI.decode(cdr['variables']['simplecos_cash_plan'].to_s).to_i)
      bill_rate = cash_plan.bill_rate
      bill_minimum = cash_plan.bill_minimum
    end
    
      
    billsec = cdr['variables']['billsec'].to_d

    if billsec == 0
      return 0
    elsif bill_minimum > 0 and billsec <= bill_minimum 
      billsec = bill_minimum 
    elsif bill_minimum > 0 and billsec > bill_minimum
      billsec = (billsec / bill_minimum).ceil * bill_minimum
    end
    
    (bill_rate * billsec) / SEGUNDOS_COBRO_BASE #@todo el cobro donde esta la unidad de cobro??
  end
  
  def create_header(cdr_file, header)
    if not File.exists?(cdr_file)
      gz = Zlib::GzipWriter.new(File.open(cdr_file, 'wb'))
      gz.write CSV.generate_line(header)
      gz.close
    end
  end
  
  def cdr_day(account, cdr)
    cdr_file = Rails.root.join(cdr_dir, account.to_s, time_cdr(cdr).to_s(:cdr_month), 'day_' + time_cdr(cdr).to_s(:cdr_day) + ".csv.gz" )
   cdr_save(account, cdr, cdr_file)
  end
  
  def cdr_month(account, cdr)
    cdr_file = Rails.root.join(cdr_dir, account.to_s, time_cdr(cdr).to_s(:cdr_month), 'month_' + time_cdr(cdr).to_s(:cdr_month) + '.csv.gz')
    cdr_save(account, cdr, cdr_file)
  end
  
  def cdr_week(account, cdr)
    cdr_file = Rails.root.join(cdr_dir, account.to_s, time_cdr(cdr).to_s(:cdr_month), 'week_' + time_cdr(cdr).to_s(:cdr_week) + '.csv.gz')
    cdr_save(account, cdr, cdr_file)
  end
  
  
  
end
