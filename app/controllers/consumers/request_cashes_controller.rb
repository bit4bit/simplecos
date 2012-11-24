class Consumers::RequestCashesController < Consumers::ApplicationController
  before_filter :authenticate_consumers_client!


  # GET /consumers/request_cashes
  # GET /consumers/request_cashes.json
  def index
    @consumers_request_cashes = Consumers::RequestCash.where(:client_id => current_consumers_client.id).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @consumers_request_cashes }
    end
  end

  # GET /consumers/request_cashes/1
  # GET /consumers/request_cashes/1.json
  def show
    @consumers_request_cash = Consumers::RequestCash.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @consumers_request_cash }
    end
  end

  # GET /consumers/request_cashes/new
  # GET /consumers/request_cashes/new.json
  def new
    @consumers_request_cash = Consumers::RequestCash.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @consumers_request_cash }
    end
  end

  # GET /consumers/request_cashes/1/edit
  def edit
    @consumers_request_cash = Consumers::RequestCash.find(params[:id])
  end

  # POST /consumers/request_cashes
  # POST /consumers/request_cashes.json
  def create
    @consumers_request_cash = Consumers::RequestCash.new(params[:consumers_request_cash])

    respond_to do |format|
      if @consumers_request_cash.save
        format.html { redirect_to @consumers_request_cash, notice: 'Request cash was successfully created.' }
        format.json { render json: @consumers_request_cash, status: :created, location: @consumers_request_cash }
      else
        format.html { render action: "new" }
        format.json { render json: @consumers_request_cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /consumers/request_cashes/1
  # PUT /consumers/request_cashes/1.json
  def update
    @consumers_request_cash = Consumers::RequestCash.find(params[:id])

    respond_to do |format|
      if @consumers_request_cash.update_attributes(params[:consumers_request_cash])
        format.html { redirect_to @consumers_request_cash, notice: 'Request cash was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @consumers_request_cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consumers/request_cashes/1
  # DELETE /consumers/request_cashes/1.json
  def destroy
    @consumers_request_cash = Consumers::RequestCash.find(params[:id])
    @consumers_request_cash.destroy

    respond_to do |format|
      format.html { redirect_to consumers_request_cashes_url }
      format.json { head :no_content }
    end
  end

  
end
