require 'spec_helper'

describe Search do
  before(:all) do
    # create certification types
    @level_1 = CertificationType.create!({:kind => 'Child Care Level 1'})
    @basic_cpr = CertificationType.create!({:kind => 'Basic First Aid'})

    # create availability types
    @fulltime = AvailabilityType.create!({:kind => 'Full-time'})
    @no_availability = AvailabilityType.create!({:kind => 'No Availability'})
  end

  before(:each) do
    @attr = FactoryGirl.attributes_for(:search)

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
                                  :street1 => '178 St NW',
                                  :dietary_accommodations => true})
  end

  it "should create a search model given valid attributes" do
    valid_search = Search.new(@attr.merge(:address => '793 blackburn place edmonton alberta T6W1C3'))
    valid_search.should be_valid
  end

  it "should be valid if all availability types are checked" do
    @params = { :availability_types => { :kind => [@fulltime.id.to_s, @no_availability.id.to_s]} }

    valid_search = Search.new(@params)
    valid_search.should be_valid
  end

  it "should be valid if 1 availability types is checked" do
    @params = { :availability_types => { :kind => [@no_availability.id.to_s]} }

    valid_search = Search.new(@params)
    valid_search.should be_valid
  end

  it "should be valid if submitting from the advanced search form" do
    @params = { :advanced_search => 'true' }

    valid_search = Search.new(@params)
    valid_search.should be_valid
  end

  it "should be valid if submitting from the simple search form" do
    @params = { :address => 'T6L5M6 Edmonton Alberta' }

    valid_search = Search.new(@params)
    valid_search.should be_valid
  end

  it "should be valid if no address is submitted" do
    @params = { :address => ''}

    valid_search = Search.new(@params)
    valid_search.should be_valid
  end

  it "should be valid if dietary acoomodations is checked" do
    @params = { :dietary_accommodations => '1',
                :advanced_search => 'true' }

    valid_search = Search.new(@params)
    valid_search.should be_valid
  end

  it "should be valid if a bunch of fields are populated" do
    @params = { :advanced_search => 'true',
                :availability_types => { :kind => [@fulltime.id.to_s, @no_availability.id.to_s]},
                :certification_types => { :kind => [@level_1.id.to_s, @basic_cpr.id.to_s ]}
    }

    valid_search = Search.new(@params)
    valid_search.should be_valid
  end

  it "where no values have been entered in the advanced search" do
    @params = { :advanced_search => 'true' }

    # Create search, check pin count
    valid_search = Search.new(@params)

    # should display all dayhomes in the system if no search criteria found
    valid_search.pin_count.should eql(2)
  end

  describe "should have pins of type" do
    describe "availability pins" do
      it "where only 1 dayhome is returned" do
        @dayhome_1.availability_types << @fulltime
        @dayhome_2.availability_types << @no_availability

        @params = { :advanced_search => 'true',
                    :availability_types => { :kind => [@fulltime.id.to_s]}}

        # Create search, check pin count
        valid_search = Search.new(@params)
        valid_search.pin_count.should eql(1)

      end

      it "where 2 dayhomes are returned" do
        @dayhome_1.availability_types << @fulltime
        @dayhome_2.availability_types << @no_availability

        @params = { :advanced_search => 'true',
                    :availability_types => { :kind => [@fulltime.id.to_s, @no_availability.id.to_s]}}

        # Create search, check pin count
        valid_search = Search.new(@params)

        valid_search.pin_count.should eql(2)
      end
    end

    describe "certificate pins" do
      it "where only 1 dayhome is returned" do
        @dayhome_1.certification_types << @level_1
        @dayhome_2.certification_types << @basic_cpr

        @params = { :advanced_search => 'true',
                    :certification_types => { :kind => [@level_1.id.to_s]}}

        # Create search, check pin count
        valid_search = Search.new(@params)
        valid_search.pin_count.should eql(1)
      end

      it "where 2 dayhomes are returned" do
        @dayhome_1.certification_types << @level_1
        @dayhome_2.certification_types << @basic_cpr

        @params = { :advanced_search => 'true',
                    :certification_types => { :kind => [@level_1.id.to_s, @basic_cpr.id.to_s]}}

        # Create search, check pin count
        valid_search = Search.new(@params)

        valid_search.pin_count.should eql(2)
      end
    end

    describe "availability pins & certification pins" do
      it "where only 1 dayhome is returned if 2 types are entered" do
        @dayhome_1.availability_types << @fulltime
        @dayhome_1.certification_types << @level_1

        @dayhome_2.availability_types << @no_availability
        @dayhome_2.certification_types << @basic_cpr

        @params = { :advanced_search => 'true',
                    :availability_types => { :kind => [@fulltime.id.to_s ]},
                    :certification_types => { :kind => [@level_1.id.to_s ]}
        }

        # Create search, check pin count
        valid_search = Search.new(@params)
        valid_search.pin_count.should eql(1)
      end

      it "where only 1 dayhome is returned if multiple enteres are entered" do
        @dayhome_1.availability_types << @fulltime
        @dayhome_1.certification_types << @level_1

        @dayhome_2.availability_types << @no_availability
        @dayhome_2.certification_types << @basic_cpr

        @params = { :advanced_search => 'true',
                    :availability_types => { :kind => [@fulltime.id.to_s ]},
                    :certification_types => { :kind => [@level_1.id.to_s, @basic_cpr.id.to_s ]}
        }

        # Create search, check pin count
        valid_search = Search.new(@params)
        valid_search.pin_count.should eql(1)
      end

      it "where 0 dayhomes are returned if criteria isn't matched" do
        @dayhome_1.availability_types << @fulltime
        @dayhome_1.certification_types << @level_1

        @dayhome_2.availability_types << @no_availability
        @dayhome_2.certification_types << @basic_cpr

        @params = { :advanced_search => 'true',
                    :availability_types => { :kind => [@no_availability.id.to_s ]},
                    :certification_types => { :kind => [@level_1.id.to_s]}
        }

        # Create search, check pin count
        valid_search = Search.new(@params)
        valid_search.pin_count.should eql(0)
      end
    end

    describe "dietary accomodation pins" do
      it "where 1 dayhome is returned if dietary accommodations is checked" do
        @params = { :dietary_accommodations => '1',
                    :advanced_search => 'true' }

        valid_search = Search.new(@params)
        valid_search.pin_count.should eql(1)
      end

      it "where 1 dayhome is returned if dietary accommodations and an availability type are checked" do
        @dayhome_1.availability_types << @fulltime
        @dayhome_1.availability_types << @no_availability

        @params = { :dietary_accommodations => '0',
                    :availability_types => { :kind => [@no_availability.id.to_s ]},
                    :advanced_search => 'true' }

        valid_search = Search.new(@params)
        valid_search.pin_count.should eql(1)
      end

      it "where 2 dayhomes are returned if dietary accommodations is not checked" do
        @params = { :dietary_accommodations => '0',
            :advanced_search => 'true' }

        valid_search = Search.new(@params)
        valid_search.pin_count.should eql(2)
      end
    end

  end
end
