class SessionsController < Devise::SessionsController
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    sign_in_and_redirect(resource_name, resource)
  end
 
  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    yield resource if block_given?
    if request.format.symbol.to_s=="js"
      return render :json => {:success => true, :csrf_token=>form_authenticity_token}
    else
      return respond_with resource, location: after_sign_in_path_for(resource)
    end   
  end
 
  def failure
    return render :json => {:success => false, :errors => ["Login failed."]}
  end
end