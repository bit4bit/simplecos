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

class XmlCdrJob < Struct.new(:xml_cdr)
  def perform
    cdr = (Hash.from_xml self.xml_cdr)['cdr']
    Rails.logger.debug(cdr)
    nibble_account = URI.decode(cdr['variables']['nibble_account'])
    create_directories(nibble_account)
    
    
  end

  private
  def create_directories(account)
    begin Dir.mkdir(Rails.root.join('cdr', account)) ;rescue; end
    begin Dir.mkdir(Rails.root.join('cdr', account, Time.now.to_s(:cdr_week))) ;rescue; end
    begin Dir.mkdir(Rails.root.join('cdr', account, Time.now.to_s(:cdr_month))) ;rescue; end
  end
  
  def cdr_to_save(cdr)
    
  end
  
  def cdr_day(account, cdr)
    cdr_file = Rails.root.join('cdr', account, Time.now.to_s(:cdr_month), Time.new.strftime('%d').to_s + '.csv.gz')
    gz = Zlib::GzipWriter.new(CSV.open(cdr_file, 'ab'))
    
  end
  
  def cdr_month(account, cdr)
  end
  
  def cdr_week(account, cdr)
  end
  
  
  
end
