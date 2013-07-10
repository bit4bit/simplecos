class ClientCashesController < ApplicationController
  load_and_authorize_resource

  # GET /client_cashes
  # GET /client_cashes.json
  def index
    @client_cashes = ClientCash.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @client_cashes }
    end
  end

  # GET /client_cashes/1
  # GET /client_cashes/1.json
  def show
    @client_cash = ClientCash.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client_cash }
    end
  end

  # GET /client_cashes/new
  # GET /client_cashes/new.json
  def new
    @client_cash = ClientCash.new
    @clients = Client.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client_cash }
    end
  end

  # GET /client_cashes/1/edit
  def edit
    @clients = Client.all
    @client_cash = ClientCash.find(params[:id])
  end

  # POST /client_cashes
  # POST /client_cashes.json
  def create
    @client_cash = ClientCash.new(params[:client_cash])
    @clients = Client.all
    respond_to do |format|
      if @client_cash.save
        format.html { redirect_to @client_cash, notice: 'Client cash was successfully created.' }
        format.json { render json: @client_cash, status: :created, location: @client_cash }
      else
        format.html { render action: "new" }
        format.json { render json: @client_cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /client_cashes/1
  # PUT /client_cashes/1.json
  def update
    @client_cash = ClientCash.find(params[:id])
    @clients = Client.all
    respond_to do |format|
      if @client_cash.update_attributes(params[:client_cash])
        format.html { redirect_to @client_cash, notice: 'Client cash was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client_cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_cashes/1
  # DELETE /client_cashes/1.json
  def destroy
    @client_cash = ClientCash.find(params[:id])
    @client_cash.destroy

    respond_to do |format|
      format.html { redirect_to client_cashes_url }
      format.json { head :no_content }
    end
  end

  # DELETE requested
  def approved
    @consumers_request_cash = Consumers::RequestCash.find(params[:client_cash_id])
    ClientCash.new({:client_id => @consumers_request_cash.client_id, :amount => @consumers_request_cash.amount}).save!
    @consumers_request_cash.destroy
    respond_to do |format|
      format.html { redirect_to client_cashes_path }
      format.json { head :no_content }
    end
  end

  #DELETE
  def dismiss
    @consumers_request_cash = Consumers::RequestCash.find(params[:client_cash_id])
    @consumers_request_cash.destroy

    respond_to do |format|
      format.html { redirect_to client_cashes_path }
      format.json { head :no_content }
    end
  end
  
end
