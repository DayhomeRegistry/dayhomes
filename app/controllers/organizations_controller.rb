class OrganizationsController < ApplicationController
  before_filter :require_user
  before_filter :require_user_to_be_organization_admin
  helper_method :sort_column, :sort_direction
  
  def show
    @organization = Organization.find(params[:id])
    @plan = Plan.where(:plan=>@organization.plan).first
    @payments = {}
    if (!@organization.stripe_customer_token.nil?)
      @payments = Stripe::Invoice.all(
        :customer => @organization.stripe_customer_token,
        :count => 100
      )
    end


    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @organization }
    end
  end

  def edit
    @organization = Organization.find(params[:id])
    @organization.day_homes.build if @organization.day_homes.blank?
    @organization.users.build if @organization.users.blank?
  end

  def update
    #raise params.to_json
    @organization = Organization.find(params[:id])
    @organization.assign_attributes(params[:organization])

    respond_to do |format|
      if @organization.save_with_payment
        #raise @organization.errors.messages.inspect
        format.html { redirect_to organization_path(@organization), notice: 'Organization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to organization_url }
      format.json { head :no_content }
    end
  end


end
