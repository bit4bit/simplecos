class Consumers::CdrController < Consumers::ApplicationController
  before_filter :authenticate_consumers_client!

  def index
    cdr_dir = Rails.root.join('cdr', current_consumers_client.id.to_s, Time.now.to_s(:cdr_month))
    @cdr_months = Dir.glob(Rails.root.join(cdr_dir, "month_*"))
    @cdr_days = Dir.glob(Rails.root.join(cdr_dir,  "day_*"))
    @cdr_weeks = Dir.glob(Rails.root.join(cdr_dir,  "week*"))
  end

  def send_cdr
    cdr_file = Rails.root.join('cdr', current_consumers_client.id.to_s, Time.now.to_s(:cdr_month), File.basename(params[:file]))

    if File.exists?(cdr_file)
      send_file cdr_file, :filename => File.basename(cdr_file).gsub(/month_|week_|day_/, '')
    else
      respond_to do |format|
        format.html { redirect_to consumers_cdr_index_path}
        format.json { head :no_content}
      end
    end
    
  end
end
