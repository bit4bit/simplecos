class Consumers::SipClientsController < Consumers::ApplicationController
  before_filter :authenticate_consumers_client!

  # GET /sip_clients
  # GET /sip_clients.json
  def index
    @sip_clients = Consumers::SipClient.where(:client_id => current_consumers_client.id).all
    @client = Client.find(current_consumers_client.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sip_clients }
    end
  end

  # GET /sip_clients/1
  # GET /sip_clients/1.json
  def show
    @sip_client = Consumers::SipClient.where(:id => params[:id], :client_id => current_consumers_client.id).first!

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sip_client }
    end
  end

  # GET /sip_clients/new
  # GET /sip_clients/new.json
  def new
    @sip_client = Consumers::SipClient.new(:client_id => current_consumers_client.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sip_client }
    end
  end

  # GET /sip_clients/1/edit
  def edit
    @sip_client = Consumers::SipClient.where(:id => params[:id], :client_id => current_consumers_client.id).first!
  end

  # POST /sip_clients
  # POST /sip_clients.json
  def create
    params[:consumers_sip_client][:client_id] = current_consumers_client.id
    @sip_client = Consumers::SipClient.new(params[:consumers_sip_client])

    respond_to do |format|
      if @sip_client.save
        format.html { redirect_to @sip_client, :client_id => current_consumers_client.id, notice: 'Sip client was successfully created.' }
        format.json { render json: @sip_client, status: :created, location: @sip_client }
      else
        format.html { render action: "new" }
        format.json { render json: @sip_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sip_clients/1
  # PUT /sip_clients/1.json
  def update
    params[:client_id] = current_consumers_client.id
    @sip_client = Consumers::SipClient.where(:id => params[:id], :client_id => current_consumers_client.id).first!

    respond_to do |format|
      if @sip_client.update_attributes(params[:sip_client])
        format.html { redirect_to @sip_client, notice: 'Sip client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sip_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sip_clients/1
  # DELETE /sip_clients/1.json
  def destroy
    @sip_client = Consumers::SipClient.where(:id => params[:id], :client_id => current_consumers_client.id)
    @client = @sip_client.client
    @sip_client.destroy

    respond_to do |format|
      format.html { redirect_to sip_clients_path(:client_id => @client.id) }
      format.json { head :no_content }
    end
  end

  before_filter :allow_admin_sip_accounts
  private
  def allow_admin_sip_accounts
    unless current_consumers_client.allow_admin_sip_accounts?
      flash[:error] = I18n.t('not_allow_admin_sip_accounts')
      redirect_to session['consumers_client_return_to']
    end
  end
  
end
