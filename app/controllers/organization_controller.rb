class OrganizationController < ApplicationController
  before_filter :require_user
  before_filter :require_user_to_be_organization_admin
  helper_method :sort_column, :sort_direction
  
  def show
    @organization = Organization.find(params[:id])
    @plan = Plan.where(:plan=>@organization.plan).first
raise @organization.stripe_customer_token.to_s
    @payments = Stripe::Invoice.all(
      :customer => @organization.stripe_customer_token,
      :count => 100
    )

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

    respond_to do |format|
      if @organization.update_attributes(params[:organization])
        #raise @organization.errors.messages.inspect
        format.html { redirect_to organzation_path(@organization), notice: 'Organization was successfully updated.' }
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
