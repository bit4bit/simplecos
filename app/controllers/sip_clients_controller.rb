class SipClientsController < ApplicationController
  load_and_authorize_resource

  # GET /sip_clients
  # GET /sip_clients.json
  def index
    @sip_clients = SipClient.where(:client_id => params[:client_id]).all
    @client = Client.find(params[:client_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sip_clients }
    end
  end

  # GET /sip_clients/1
  # GET /sip_clients/1.json
  def show
    @sip_client = SipClient.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sip_client }
    end
  end

  # GET /sip_clients/new
  # GET /sip_clients/new.json
  def new
    @sip_client = SipClient.new(:client_id => params[:client_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sip_client }
    end
  end

  # GET /sip_clients/1/edit
  def edit
    @sip_client = SipClient.find(params[:id])
  end

  # POST /sip_clients
  # POST /sip_clients.json
  def create
    @sip_client = SipClient.new(params[:sip_client])

    respond_to do |format|
      if @sip_client.save
        format.html { redirect_to @sip_client, notice: 'Sip client was successfully created.' }
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
    @sip_client = SipClient.find(params[:id])

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
    @sip_client = SipClient.find(params[:id])
    @client = @sip_client.client
    @sip_client.destroy

    respond_to do |format|
      format.html { redirect_to sip_clients_path(:client_id => @client.id) }
      format.json { head :no_content }
    end
  end
end
