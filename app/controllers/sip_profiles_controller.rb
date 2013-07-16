class SipProfilesController < ApplicationController
  load_and_authorize_resource

  # GET /sip_profiles
  # GET /sip_profiles.json
  def index
    @sip_profiles = SipProfile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sip_profiles }
    end
  end

  # GET /sip_profiles/1
  # GET /sip_profiles/1.json
  def show
    @sip_profile = SipProfile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sip_profile }
    end
  end

  # GET /sip_profiles/new
  # GET /sip_profiles/new.json
  def new
    @sip_profile = SipProfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sip_profile }
    end
  end

  # GET /sip_profiles/1/edit
  def edit
    @sip_profile = SipProfile.find(params[:id])
  end

  # POST /sip_profiles
  # POST /sip_profiles.json
  def create
    @sip_profile = SipProfile.new(params[:sip_profile])

    respond_to do |format|
      if @sip_profile.save
        format.html { redirect_to @sip_profile, notice: 'Sip profile was successfully created.' }
        format.json { render json: @sip_profile, status: :created, location: @sip_profile }
      else
        format.html { render action: "new" }
        format.json { render json: @sip_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sip_profiles/1
  # PUT /sip_profiles/1.json
  def update
    @sip_profile = SipProfile.find(params[:id])

    respond_to do |format|
      if @sip_profile.update_attributes(params[:sip_profile])
        format.html { redirect_to @sip_profile, notice: 'Sip profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sip_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sip_profiles/1
  # DELETE /sip_profiles/1.json
  def destroy
    @sip_profile = SipProfile.find(params[:id])
    @sip_profile.destroy

    respond_to do |format|
      format.html { redirect_to sip_profiles_url }
      format.json { head :no_content }
    end
  end
end
