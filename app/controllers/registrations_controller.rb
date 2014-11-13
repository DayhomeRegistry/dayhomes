class RegistrationsController < Devise::RegistrationsController
  # POST /resource
  def create
    build_resource(sign_up_params)

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        authenticate_scope!
        # if params["user_profile_info"]["receive_promotional_email"]=="1"
        #   # Make a call to mailchimp
        #   # TODO
        # end
        if request.format.symbol.to_s=="js"
          return render :json => {:success => true}
        else
          if(session["spree_user_return_to"])
            spree_user_return_to = session["spree_user_return_to"]
            session["spree_user_return_to"] = nil

            order = Spree::Order.incomplete.find_by(number: session["spree_guest_order_number"])
            order.associate_user!(current_user) if order.user.blank? || order.email.blank?
            session["spree_guest_order_number"] = nil

            return redirect_to(spree_user_return_to)
          else
            return respond_with resource, location: after_sign_up_path_for(resource)
          end
        end      
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        if request.format.symbol.to_s=="js"
          return render :json => {:success => true}
        else
          return respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      end
    else
      clean_up_passwords resource
      if request.format.symbol.to_s=="js"
        #render :json => {:success => true, :errors => resource.errors.to_json}
        return render json: {:success => false, :errors => resource.errors.to_json}
      else
        return respond_with resource
      end
    end
  end

  private

  def redirect_back_or_default(default)
    byebug
    redirect_to(session["spree_user_return_to"] || default)
    session["spree_user_return_to"] = nil
  end
  
end