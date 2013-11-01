
class Consumers::CdrController < Consumers::ApplicationController
  before_filter :authenticate_consumers_client!

  def index
    cdrs = dirs_cdr
    @cdr_months = cdrs[:cdr_months]
    @cdr_weeks = cdrs[:cdr_weeks]
    @cdr_days = cdrs[:cdr_days]
  end

  def send_cdr
    cdrs = dirs_cdr
    cdr_file = nil
    cdrs.each do |key, cdr|
      cdr.each {|d| 
        if d[:crypt] == params[:id]
           cdr_file = d[:file]
          break
        end
      }
      break unless cdr_file.nil?
    end
    
    if File.exists?(cdr_file)
      send_file cdr_file, :filename => File.basename(cdr_file).gsub(/month_|week_|day_/, '')
    else
      respond_to do |format|
        format.html { redirect_to consumers_cdr_index_path}
        format.json { head :no_content}
      end
    end
    
  end
  private
  def dirs_cdr
    cdr_dir_root = Rails.root.join('cdr')
    cdr_dir = cdr_dir_root.join(current_consumers_client.id.to_s, Time.now.to_s(:cdr_month))
    cdr_months = Dir.glob(Rails.root.join(cdr_dir_root, current_consumers_client.id.to_s,"*","month_*"))
    cdr_months.collect!{|d| {:title => File.basename(d.gsub(/month_|day_|week_/,'')), 
        :crypt =>  Base64.encode64(Digest::MD5.digest(d).crypt(current_consumers_client.salt.to_s)),
        :file => d
      }}
    cdr_days = Dir.glob(Rails.root.join(cdr_dir,  "day_*"))
    cdr_days.collect!{|d| {:title => File.basename(d.gsub(/month_|day_|week_/,'')),
        :crypt => Base64.encode64(Digest::MD5.digest(d).crypt(current_consumers_client.salt.to_s)),
        :file => d
      }}
    cdr_weeks = Dir.glob(Rails.root.join(cdr_dir,  "week*"))
    cdr_weeks.collect!{|d| {:title => File.basename(d.gsub(/month_|day_|week_/,'')),
        :crypt => Base64.encode64(Digest::MD5.digest(d).crypt(current_consumers_client.salt.to_s)),
        :file => d
      }}

    {:cdr_months => cdr_months, :cdr_days => cdr_days, :cdr_weeks => cdr_weeks}
  end
  
end
