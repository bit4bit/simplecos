class PublicCarriersController < ApplicationController
  load_and_authorize_resource

  # GET /public_carriers
  # GET /public_carriers.json
  def index
    @public_carriers = PublicCarrier.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @public_carriers }
    end
  end

  # GET /public_carriers/1
  # GET /public_carriers/1.json
  def show
    @public_carrier = PublicCarrier.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @public_carrier }
    end
  end

  # GET /public_carriers/new
  # GET /public_carriers/new.json
  def new
    @public_carrier = PublicCarrier.new
    @public_carrier.trunks.build
    @freeswitches = Freeswitch.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @public_carrier }
    end
  end

  # GET /public_carriers/1/edit
  def edit
    @freeswitches = Freeswitch.all
    @public_carrier = PublicCarrier.find(params[:id])
  end

  # POST /public_carriers
  # POST /public_carriers.json
  def create
    @freeswitches = Freeswitch.all
    @public_carrier = PublicCarrier.new(params[:public_carrier])

    respond_to do |format|
      if @public_carrier.save
        format.html { redirect_to @public_carrier, notice: 'Public carrier was successfully created.' }
        format.json { render json: @public_carrier, status: :created, location: @public_carrier }
      else
        format.html { render action: "new" }
        format.json { render json: @public_carrier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /public_carriers/1
  # PUT /public_carriers/1.json
  def update
    @freeswitches = Freeswitch.all
    @public_carrier = PublicCarrier.find(params[:id])

    respond_to do |format|
      if @public_carrier.update_attributes(params[:public_carrier])
        format.html { redirect_to @public_carrier, notice: 'Public carrier was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @public_carrier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /public_carriers/1
  # DELETE /public_carriers/1.json
  def destroy
    @public_carrier = PublicCarrier.find(params[:id])
    @public_carrier.destroy

    respond_to do |format|
      format.html { redirect_to public_carriers_url }
      format.json { head :no_content }
    end
  end
end
