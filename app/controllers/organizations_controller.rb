class OrganizationsController < ApplicationController
  before_filter :require_user, :except=>'show'
  before_filter :require_user_to_be_organization_admin, :except=>'show'
  helper_method :sort_column, :sort_direction
  
  def show
    debugger
    @organization = Organization.find(params[:id])
    @plan = Plan.where(:plan=>@organization.plan).first
    @payments = {}
    if (!@organization.stripe_customer_token.nil?)
      @payments = Stripe::Invoice.all(
        :customer => @organization.stripe_customer_token,
        :count => 100
      )
    end
    @day_homes = @organization.day_homes.order(sort_column + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10)

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
    @organization.update_attributes(params[:organization])

    respond_to do |format|
      if @organization.save_with_payment
        #raise @organization.errors.messages.inspect
        format.html { redirect_to organization_path(@organization), notice: 'Organization was successfully updated.' }
        format.json { head :no_content }
      else
        flash.now[:error] = @organization.errors.full_messages.join(',')
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

  def confirm_cancel
    @organization = Organization.find(params[:organization_id])
    if (@organization.id != current_user.organization.id)
      @organization = current_user.organization
      flash['error'] = "It seems there was an error with the organization you tried to cancel.  Please try again."
    end
  end

  def cancel
    begin
      too_expensive = !params["too_expensive"].nil?
      no_contact = !params["no_contact"].nil?
      closed = !params["closed"].nil?
      comments = params["comments"]

      @organization = Organization.find(params[:organization_id])
      if (@organization.id != current_user.organization.id)
        @organization = current_user.organization
        raise "It seems there was an error with the organization you tried to cancel.  Please try again."
      end

      @organization.transaction do  
        #delete dayhomes
        @organization.day_homes.each do |day_home|
          day_home.deleted = true;
          day_home.deleted_on = DateTime.now();
          day_home.save
        end

        #delete locations
        # @organization.locations.each do |location|
        #   location.deleted = true;
        #   location.deleted_on = DateTime.now();
        #   location.save
        # end

        #cancel subscription
        @organization.destroy_customer
        @organization.stripe_customer_token = nil
        @organization.plan = 'baby'
        @organization.save

      end
      DayHomeMailer.day_home_cancel_confirmation(@organization).deliver
      DayHomeMailer.day_home_cancel_notification(@organization,too_expensive,no_contact,closed,comments).deliver
    rescue => e    
      if(!e.message.nil?)
        flash.now['error'] = e.message
        logger.error e.message
      else
        flash.now['error'] = e
        logger.error e
      end

      return confirm_cancel(@organization)  
    end
    flash["success"] = "You have been removed from our system."
    redirect_to logout_path
  end

  private
  def sort_column
    Organization.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"    
  end  
end
