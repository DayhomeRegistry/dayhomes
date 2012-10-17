require 'spec_helper'

describe "admin_agencies/edit" do
  before(:each) do
    @agency = assign(:agency, stub_model(Admin::Agency,
      :name => "MyString",
      :email => "MyString"
    ))
  end

  it "renders the edit agency form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_agencies_path(@agency), :method => "post" do
      assert_select "input#agency_name", :name => "agency[name]"
      assert_select "input#agency_email", :name => "agency[email]"
    end
  end
end
