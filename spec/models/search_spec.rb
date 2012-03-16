require 'spec_helper'

describe Search do
  before(:all) do
    AvailabilityType.destroy_all
    DayHomeAvailabilityType.destroy_all
    CertificationType.destroy_all
    DayHomeCertificationType.destroy_all

    # create certification types
    @level_1 = CertificationType.create!({:kind => 'Child Care Level 1'})
    @basic_cpr = CertificationType.create!({:kind => 'Basic First Aid'})

    # create availability types
    @fulltime = AvailabilityType.create!({:kind => 'Full-time'})
    @no_availability = AvailabilityType.create!({:kind => 'No Availability'})
  end

  before(:each) do
    @attr = FactoryGirl.attributes_for(:search)
  end

  it "should create a search model given valid attributes" do
    valid_search = Search.new(@attr.merge(:address => '793 blackburn place edmonton alberta T6W1C3'))
    valid_search.should be_valid
  end

  it "should be valid if all availability types are checked" do
    @params = { :availability_types => { :kind => { :'1' => 1, :'2' => 2, :'3' => 3  } }}

    valid_search = Search.new(@params)
    valid_search.should be_valid
  end

  it "should be valid if 1 availability types is checked" do
    @params = { :availability_types => { :kind => { :'1' => 1 } }}

    valid_search = Search.new(@params)
    valid_search.should be_valid
  end

  it "should be valid if submitting from the advanced search form" do
    @params = { :advanced_search => 'true' }

    valid_search = Search.new(@params)
    valid_search.should be_valid
  end

  it "should be valid if a bunch of fields are populated" do
    @params = { :advanced_search => 'true',
                :address => 'T6L5M6 Edmonton Alberta Canada',
                :availability_types => { :kind => { :'1' => 1, :'2' => 2, :'3' => 3  } },
                :certification_types => { :kind => { :'1' => 1, :'2' => 2, :'3' => 3  } }
    }

    @params = { :advanced_search => 'true',
                :availability_types => { :kind => [@fulltime.id.to_s, @no_availability.id.to_s]},
                :certification_types => { :kind => [@level_1.id.to_s, @basic_cpr.id.to_s ]}
    }

    valid_search = Search.new(@params)
    valid_search.should be_valid
  end

  it "should be valid if all fields not populated" do
    @params = { :advanced_search => 'true',
                :address => ''}

    valid_search = Search.new(@params)
    valid_search.should be_valid
  end


  describe "should have pins of type" do
    describe "availability pins" do
      before(:each) do
        @dayhome_1 = DayHome.create!({:name => "DayHome 1",
                                     :gmaps =>  true,
                                     :city =>  'Edmonton',
                                     :province =>  'AB',
                                     :street2 =>  '',
                                     :postal_code => 'T5N1Y6',
                                     :street1 => '131 St NW'})
        @dayhome_2 = DayHome.create!({:name => "DayHome 2",
                                      :gmaps =>  true,
                                      :city =>  'Edmonton',
                                      :province =>  'AB',
                                      :street2 =>  '',
                                      :postal_code => 'T5S1R5',
                                      :street1 => '178 St NW'})
      end

      it "where count should be 2" do
        @dayhome_1.availability_types << @fulltime
        @dayhome_2.availability_types << @no_availability

        @params = { :advanced_search => 'true',
                    :availability_types => { :kind => [@fulltime.id.to_s, @no_availability.id.to_s]}}

        # Create search, apply filter
        valid_search = Search.new(@params)
        valid_search.dayhome_filter(@params)

        valid_search.pin_count.should eql(2)
      end


    end


  end
end
