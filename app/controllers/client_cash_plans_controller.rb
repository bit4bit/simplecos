class ClientCashPlansController < ApplicationController
  load_and_authorize_resource

  # GET /client_cash_plans
  # GET /client_cash_plans.json
  def index
    @client_cash_plans = ClientCashPlan.where(:client_id => params[:client_id]).paginate :page => params[:page]
    @client = Client.find(params[:client_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @client_cash_plans }
    end
  end

  # GET /client_cash_plans/1
  # GET /client_cash_plans/1.json
  def show
    @client_cash_plan = ClientCashPlan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client_cash_plan }
    end
  end

  # GET /client_cash_plans/new
  # GET /client_cash_plans/new.json
  def new
    @client_cash_plan = ClientCashPlan.new(:client_id => params[:client_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client_cash_plan }
    end
  end

  # GET /client_cash_plans/1/edit
  def edit
    @client_cash_plan = ClientCashPlan.find(params[:id])
  end

  # POST /client_cash_plans
  # POST /client_cash_plans.json
  def create
    @client_cash_plan = ClientCashPlan.new(params[:client_cash_plan])

    respond_to do |format|
      if @client_cash_plan.save
        format.html { redirect_to @client_cash_plan, notice: 'Client cash plan was successfully created.' }
        format.json { render json: @client_cash_plan, status: :created, location: @client_cash_plan }
      else
        format.html { render action: "new" }
        format.json { render json: @client_cash_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /client_cash_plans/1
  # PUT /client_cash_plans/1.json
  def update
    @client_cash_plan = ClientCashPlan.find(params[:id])

    respond_to do |format|
      if @client_cash_plan.update_attributes(params[:client_cash_plan])
        format.html { redirect_to @client_cash_plan, notice: 'Client cash plan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client_cash_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /client_cash_plans/clone/1
  def clone
    @client_cash_plan = ClientCashPlan.find(params[:client_cash_plan_id])
    nclient_cash_plan = @client_cash_plan.dup
    if nclient_cash_plan.save
      respond_to do |format|
        format.html { redirect_to client_cash_plans_url(:client_id => @client_cash_plan.client_id) }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to client_cash_plans_url(:client_id => @client_cash_plan.client_id) }      
        format.json { head :no_content }
      end
    end
  end
  
  # DELETE /client_cash_plans/1
  # DELETE /client_cash_plans/1.json
  def destroy
    @client_cash_plan = ClientCashPlan.find(params[:id])
    @client_cash_plan.destroy

    respond_to do |format|
      format.html { redirect_to client_cash_plans_url(:client_id => @client_cash_plan.client_id) }
      format.json { head :no_content }
    end
  end
end
