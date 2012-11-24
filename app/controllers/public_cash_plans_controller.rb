class PublicCashPlansController < ApplicationController
  load_and_authorize_resource

  # GET /public_cash_plans
  # GET /public_cash_plans.json
  def index
    @public_cash_plans = PublicCashPlan.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @public_cash_plans }
    end
  end

  # GET /public_cash_plans/1
  # GET /public_cash_plans/1.json
  def show
    @public_cash_plan = PublicCashPlan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @public_cash_plan }
    end
  end

  # GET /public_cash_plans/new
  # GET /public_cash_plans/new.json
  def new
    @public_cash_plan = PublicCashPlan.new
    @carriers = PublicCarrier.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @public_cash_plan }
    end
  end

  # GET /public_cash_plans/1/edit
  def edit
    @public_cash_plan = PublicCashPlan.find(params[:id])
    @carriers = PublicCarrier.all
  end

  # POST /public_cash_plans
  # POST /public_cash_plans.json
  def create
    @public_cash_plan = PublicCashPlan.new(params[:public_cash_plan])
    @carriers = PublicCarrier.all
    respond_to do |format|
      if @public_cash_plan.save
        format.html { redirect_to @public_cash_plan, notice: 'Public cash plan was successfully created.' }
        format.json { render json: @public_cash_plan, status: :created, location: @public_cash_plan }
      else
        format.html { render action: "new" }
        format.json { render json: @public_cash_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /public_cash_plans/1
  # PUT /public_cash_plans/1.json
  def update
    @public_cash_plan = PublicCashPlan.find(params[:id])

    respond_to do |format|
      if @public_cash_plan.update_attributes(params[:public_cash_plan])
        format.html { redirect_to @public_cash_plan, notice: 'Public cash plan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @public_cash_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /public_cash_plans/1
  # DELETE /public_cash_plans/1.json
  def destroy
    @public_cash_plan = PublicCashPlan.find(params[:id])
    @public_cash_plan.destroy

    respond_to do |format|
      format.html { redirect_to public_cash_plans_url }
      format.json { head :no_content }
    end
  end
end
