class Admin::AgenciesController < ApplicationController
  helper_method :sort_column, :sort_direction
  # GET /admin/agencies
  # GET /admin/agencies.json
  def index
    @agencies = Agency.all

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @agencies }
    end
  end

  # GET /admin/agencies/1
  # GET /admin/agencies/1.json
  def show
    @agency = Agency.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @agency }
    end
  end

  # GET /admin/agencies/new
  # GET /admin/agencies/new.json
  def new
    @agency = Agency.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @agency }
    end
  end

  # POST /admin/agencies
  # POST /admin/agencies.json
  def create
    #raise params.to_json
    @agency = Agency.new(params[:agency])
    respond_to do |format|
      if @agency.valid? 
        #add the users
        if !params[:assign_user_ids].nil?
          params[:assign_user_ids].each do |id|
            @agency.add_user_by_id(id)
          end
        end
        #and save
        if @agency.save
          format.html { redirect_to admin_agency_path(@agency), notice: 'Agency was successfully created.' }
          format.json { render json: @agency, status: :created, location: @agency }
        else
          format.html { render action: "new" }
          format.json { render json: @agency.errors, status: :unprocessable_entity }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @agency.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /admin/agencies/1/edit
  def edit
    @agency = Agency.find(params[:id])
    @agency.day_homes.build if @agency.day_homes.blank?
    @agency.users.build if @agency.users.blank?
  end

  # PUT /admin/agencies/1
  # PUT /admin/agencies/1.json
  def update
    #raise params.to_json
    @agency = Agency.find(params[:id])

    respond_to do |format|
      if @agency.update_attributes(params[:agency])
        #raise @agency.errors.messages.inspect
        format.html { redirect_to admin_agency_path(@agency), notice: 'Agency was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @agency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/agencies/1
  # DELETE /admin/agencies/1.json
  def destroy
    @agency = Agency.find(params[:id])
    @agency.destroy

    respond_to do |format|
      format.html { redirect_to admin_agencies_url }
      format.json { head :no_content }
    end
  end
end
