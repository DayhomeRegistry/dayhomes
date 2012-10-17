require 'spec_helper'

describe "admin_agencies/show" do
  before(:each) do
    @agency = assign(:agency, stub_model(Admin::Agency,
      :name => "Name",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Email/)
  end
end
