require 'spec_helper'

describe SearchesController do
  render_views

  before(:each) do
    login_regular_user
    @attr = FactoryGirl.attributes_for(:search)
  end

  describe "GET 'index'" do
    describe "without query params" do
      it "should be successful" do
        get :index
        response.should be_success
      end

      it "should have a map" do
        get :index, @attr
        response.should have_selector("div.map_container")
      end

      it "should have an address field" do
        get :index
        response.should have_selector("input[name='search[address]'][type='text']")
      end

      it "should have a search button" do
        get :index
        response.should have_selector("input[name='commit'][type='submit']")
      end

      describe "advanced search form" do
        before(:each) do
          @full_time_full_days = AvailabilityType.create!({:availability => 'Full-time', :kind => 'Full Days'})
          @full_time_after_school = AvailabilityType.create!({:availability => 'Full-time', :kind => 'After School'})
          @full_time_before_school = AvailabilityType.create!({:availability => 'Full-time', :kind => 'Before School'})
          @part_time_full_days = AvailabilityType.create!({:availability => 'Part-time', :kind => 'Full Days'})
          @part_time_morning = AvailabilityType.create!({:availability => 'Part-time', :kind => 'Morning'})
          @part_time_afternoon = AvailabilityType.create!({:availability => 'Part-time', :kind => 'Afternoon'})
          @part_time_after_school = AvailabilityType.create!({:availability => 'Part-time', :kind => 'After School'})
          @part_time_before_school = AvailabilityType.create!({:availability => 'Part-time', :kind => 'Before School'})

          @level_1 = CertificationType.create!({:kind => 'Child Care Level 1'})
          @level_2 = CertificationType.create!({:kind => 'Child Care Level 2'})
          @level_3 = CertificationType.create!({:kind => 'Child Care Level 3'})
          @basic_cpr = CertificationType.create!({:kind => 'Basic First Aid'})
          @advanced_cpr = CertificationType.create!({:kind => 'Advanced First Aid'})
          @infant_cpr = CertificationType.create!({:kind => 'Infant CPR'})
        end

        it "should exist" do
          get :index
          response.should have_selector('form', :id => 'advanced-search')
        end

        it "should have advanced search address text box" do
          get :index
          response.should have_selector("form") do |node|
            node.should have_selector('input', :id => 'search_address')
          end
        end

        it "should have availability type checkboxes" do
          get :index
          response.should have_selector("form") do |node|
            node.should have_selector('input', :type => 'checkbox', :value => @full_time_full_days.id.to_s)
            node.should have_selector('input', :type => 'checkbox', :value => @full_time_after_school.id.to_s)
            node.should have_selector('input', :type => 'checkbox', :value => @full_time_before_school.id.to_s)
            node.should have_selector('input', :type => 'checkbox', :value => @part_time_full_days.id.to_s)
            node.should have_selector('input', :type => 'checkbox', :value => @part_time_morning.id.to_s)
            node.should have_selector('input', :type => 'checkbox', :value => @part_time_afternoon.id.to_s)
            node.should have_selector('input', :type => 'checkbox', :value => @part_time_after_school.id.to_s)
            node.should have_selector('input', :type => 'checkbox', :value => @part_time_before_school.id.to_s)
          end
        end

        it "should have certification type checkboxes" do
          get :index
          response.should have_selector("form") do |node|
            node.should have_selector('input', :type => 'checkbox', :value => @level_1.id.to_s)
            node.should have_selector('input', :type => 'checkbox', :value => @level_2.id.to_s)
            node.should have_selector('input', :type => 'checkbox', :value => @level_3.id.to_s)
            node.should have_selector('input', :type => 'checkbox', :value => @basic_cpr.id.to_s)
            node.should have_selector('input', :type => 'checkbox', :value => @advanced_cpr.id.to_s)
            node.should have_selector('input', :type => 'checkbox', :value => @infant_cpr.id.to_s)
          end
        end

      end
    end


    describe "with query params" do
      it "should be successful" do
        get :index, @attr
        response.should be_success
      end

      it "should be successful without address" do
        get :index, :search => @attr.merge(:address => "")
        response.should be_success
      end

      it "should be successful with dietary accomodations" do
        get :index, :search => @attr.merge(:advanced_search => true,
                                           :dietary_accommodations => '1')
        response.should be_success
      end

      it "should be successful with availability type query params" do
        @params = { :advanced_search => true,
                    :address => 'T6L5M6 Edmonton Alberta Canada',
                    :availability_types => { :kind => { :'1' => 1, :'2' => 2, :'3' => 3  } }}

        get :index, :search => @params
        response.should be_success
      end
    end

    describe "failure" do
      it "should display an error if address can't be geocoded'" do
        get :index, :search => @attr.merge(:address => "1111111111111111111111asdfasdfasdfasdf1111111111111111fail")
        flash[:error].should_not be_nil
      end
    end

  end
end
