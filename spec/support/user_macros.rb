module UserMacros

  # ==========================
  # = Regular Front End User =
  # ==========================
  
  def login_admin_user
    login_user
    @user.stub!(:admin?).and_return(true)
  end
  
  def login_regular_user
    login_user
    @user.stub!(:admin?).and_return(false)
  end
  
  def login_user
    @user = FactoryGirl.create(:user)
    @user.stub!(:active?).and_return(true)
    @controller.stub!(:current_user).and_return(@user)
  end

  def logout_user
    @controller.stub!(:current_user).and_return(nil)
  end

end

RSpec.configure do |config|
  config.include UserMacros
end