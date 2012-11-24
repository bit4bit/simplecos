class FreeswitchesController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!, :except => [:dialplan, :directory, :configuration, :bill]

  
  # GET /freeswitches
  # GET /freeswitches.json
  def index
    @freeswitches = Freeswitch.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @freeswitches }
    end
  end

  # GET /freeswitches/1
  # GET /freeswitches/1.json
  def show
    @freeswitch = Freeswitch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @freeswitch }
    end
  end

  # GET /freeswitches/new
  # GET /freeswitches/new.json
  def new
    @freeswitch = Freeswitch.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @freeswitch }
    end
  end

  # GET /freeswitches/1/edit
  def edit
    @freeswitch = Freeswitch.find(params[:id])
  end

  # POST /freeswitches
  # POST /freeswitches.json
  def create
    @freeswitch = Freeswitch.new(params[:freeswitch])

    respond_to do |format|
      if @freeswitch.save
        format.html { redirect_to @freeswitch, notice: 'Freeswitch was successfully created.' }
        format.json { render json: @freeswitch, status: :created, location: @freeswitch }
      else
        format.html { render action: "new" }
        format.json { render json: @freeswitch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /freeswitches/1
  # PUT /freeswitches/1.json
  def update
    @freeswitch = Freeswitch.find(params[:id])

    respond_to do |format|
      if @freeswitch.update_attributes(params[:freeswitch])
        format.html { redirect_to @freeswitch, notice: 'Freeswitch was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @freeswitch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /freeswitches/1
  # DELETE /freeswitches/1.json
  def destroy
    @freeswitch = Freeswitch.find(params[:id])
    @freeswitch.destroy

    respond_to do |format|
      format.html { redirect_to freeswitches_url }
      format.json { head :no_content }
    end
  end


  # POST.xml
  def dialplan
    authenticate_freeswitch_by_ip
    logger.debug("Dialplan quest:%s" %params.to_s)
    @freeswitch = Freeswitch.find_by_ip(params['FreeSWITCH-IPv4'])
    if @freeswitch
      respond_to do |format|
        format.xml
      end
    else
      render :template => 'freeswitches/not_response'
    end
    
  end
  
  # POST.xml
  def directory
    authenticate_freeswitch_by_ip
    logger.debug("Directory quest:%s" % params.to_s)
    @freeswitch = Freeswitch.find_by_ip(params['FreeSWITCH-IPv4'])
    @clients = Client.all
    @data = params
    if @data['purpose'] == 'gateways'
      directory_gateways
    else
      respond_to do |format|
        format.xml
      end
    end
  end
  
  def directory_gateways
    render :template => 'freeswitches/directory_gateways'
  end
  
  #CONFIGURATION FSXML
  def configuration
    authenticate_freeswitch_by_ip
    @freeswitch = Freeswitch.find_by_ip(params['FreeSWITCH-IPv4'])
    @data = params
    if @data['section'] == 'configuration' and @data['key_value'] == 'sofia.conf'
      configuration_sofia
    elsif @data['section'] == 'configuration' and @data['key_value'] == 'nibblebill_curl.conf'
      configuration_nibblebill_curl
    else
      respond_to do |format|
        format.xml
      end
    end
  end
  
  def configuration_sofia
    if @data['profile'] == 'external' 
      render :template => 'freeswitches/configuration/external',  :layout => 'fsxml/sofia_conf'
    else
      render :template => 'freeswitches/not_response'
    end
  end

  def configuration_nibblebill_curl
    render :template => 'freeswitches/configuration/nibblebill_curl'
  end
  

  #GET,POST
  def bill
    authenticate_freeswitch_by_ip

    @client = Client.find(params[:client])
    if @client.nil? and not params[:billaccount].nil?
      @client = Client.find(params[:billaccount]);
    end
    
    if not params[:billamount].nil? and params[:billamount].to_f > 0
      @client.increment!(:balance, -(params[:billamount].to_f))
      @client.reload
    end

    unless @client
      render :template => 'freeswitches/not_response'
    else
      respond_to do |f|
        f.xml
      end
    end
    
  end

  
  private
  def authenticate_freeswitch_by_ip
    unless Freeswitch.where(:ip => request.remote_ip).exists? or request.local?
      raise CanCan::AccessDenied
    end
  end
  
end
