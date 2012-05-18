require 'spec_helper'

describe Search do
  before(:all) do
    # create certification types
    @level_1 = CertificationType.create!({:kind => 'Child Care Level 1'})
    @basic_cpr = CertificationType.create!({:kind => 'Basic First Aid'})

    # create availability types
    @full_time_full_days = AvailabilityType.create!({:availability => 'Full-time', :kind => 'Full Days'})
    @part_time_morning = AvailabilityType.create!({:availability => 'Part-time', :kind => 'Morning'})
  end

  before(:each) do
    @attr = FactoryGirl.attributes_for(:search)

    @dayhome_1 = DayHome.create!({:name => "DayHome 1",
                                  :gmaps =>  true,
                                  :city =>  'Edmonton',
                                  :province =>  'AB',
                                  :street2 =>  '',
                                  :postal_code => 'T5N1Y6',
                                  :street1 => '131 St NW',
                                  :slug => 'day_home_1',
                                  :licensed => true,
                                  :email => 'dh1@dayhomeregistry.com',
                                  :phone_number => '17809072969'
                                  })

    @dayhome_2 = DayHome.create!({:name => "DayHome 2",
                                  :gmaps =>  true,
                                  :city =>  'Edmonton',
                                  :province =>  'AB',
                                  :street2 =>  '',
                                  :postal_code => 'T5S1R5',
                                  :street1 => '178 St NW',
                                  :dietary_accommodations => true,
                                  :slug => 'day_home_2',
                                  :licensed => false,
                                  :email => 'dh2@dayhomeregistry.com',
                                  :phone_number => '17809042969'
                                 })
  end

  it "should create a search model given valid attributes" do
    valid_search = Search.new(@attr.merge(:address => '793 blackburn place edmonton alberta T6W1C3'))
    valid_search.should be_valid
  end

  it "should be valid if all availability types are checked" do
    @params = { :availability_types => { :kind => [@full_time_full_days.id.to_s, @part_time_morning.id.to_s]} }

    valid_search = Search.new(@params)
    valid_search.should be_valid
  end

  it "should be valid if 1 availability types is checked" do
    @params = { :availability_types => { :kind => [@part_time_morning.id.to_s]} }

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
                :availability_types => { :kind => [@full_time_full_days.id.to_s, @part_time_morning.id.to_s]},
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

  describe "auto_adjust" do
    describe "should be true" do
      it "dayhomes found" do
        @dayhome_1.availability_types << @full_time_full_days

        @params = { :advanced_search => 'true',
                    :availability_types => { :kind => [@full_time_full_days.id.to_s]}}

        valid_search = Search.new(@params)
        valid_search.search_pin.should be_nil
        valid_search.auto_adjust.should be_true
      end
    end

    describe "should be false" do
      it "when no dayhomes found" do
        @params = { :advanced_search => 'true',
                    :availability_types => { :kind => [@part_time_morning.id.to_s]} }

        valid_search = Search.new(@params)
        valid_search.auto_adjust.should be_false
      end

      it "when search pin is entered" do
        @params = { :address => 't6l5m6' }

        valid_search = Search.new(@params)
        valid_search.auto_adjust.should be_false
      end
    end
  end

  describe "zoom" do
    it "should be 11 if search pin is nil" do
      @params = { :advanced_search => 'true',
                  :availability_types => { :kind => [@part_time_morning.id.to_s]} }

      valid_search = Search.new(@params)
      valid_search.zoom.should eql(11)
    end

    it "should be 12 if search pin is populated" do
      @params = { :address => 't6l5m6' }

      valid_search = Search.new(@params)
      valid_search.zoom.should eql(12)
    end
  end

  describe "center latitude and center longitude" do
    it "should be equal to the search pin" do
      @params = { :address => 't6l5m6' }

      valid_search = Search.new(@params)
      valid_search.center_latitude.should eql(33)
      valid_search.center_longitude.should eql(33)
    end

    it "should be set to edmonton" do
      @params = { :advanced_search => 'true',
                  :availability_types => { :kind => [@part_time_morning.id.to_s]} }

      valid_search = Search.new(@params)
      valid_search.center_latitude.should eql(53.543564)
      valid_search.center_longitude.should eql(-113.507074)
    end
  end

  describe "should have pins of type" do
    describe "availability pins" do
      it "where only 1 dayhome is returned" do
        @dayhome_1.availability_types << @full_time_full_days
        @dayhome_2.availability_types << @part_time_morning

        @params = { :advanced_search => 'true',
                    :availability_types => { :kind => [@full_time_full_days.id.to_s]}}

        # Create search, check pin count
        valid_search = Search.new(@params)
        valid_search.pin_count.should eql(1)

      end

      it "where 2 dayhomes are returned" do
        @dayhome_1.availability_types << @full_time_full_days
        @dayhome_2.availability_types << @part_time_morning

        @params = { :advanced_search => 'true',
                    :availability_types => { :kind => [@full_time_full_days.id.to_s, @part_time_morning.id.to_s]}}

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
        @dayhome_1.availability_types << @full_time_full_days
        @dayhome_1.certification_types << @level_1

        @dayhome_2.availability_types << @part_time_morning
        @dayhome_2.certification_types << @basic_cpr

        @params = { :advanced_search => 'true',
                    :availability_types => { :kind => [@full_time_full_days.id.to_s ]},
                    :certification_types => { :kind => [@level_1.id.to_s ]}
        }

        # Create search, check pin count
        valid_search = Search.new(@params)
        valid_search.pin_count.should eql(1)
      end

      it "where only 1 dayhome is returned if multiple enteres are entered" do
        @dayhome_1.availability_types << @full_time_full_days
        @dayhome_1.certification_types << @level_1

        @dayhome_2.availability_types << @part_time_morning
        @dayhome_2.certification_types << @basic_cpr

        @params = { :advanced_search => 'true',
                    :availability_types => { :kind => [@full_time_full_days.id.to_s ]},
                    :certification_types => { :kind => [@level_1.id.to_s, @basic_cpr.id.to_s ]}
        }

        # Create search, check pin count
        valid_search = Search.new(@params)
        valid_search.pin_count.should eql(1)
      end

      it "where 0 dayhomes are returned if criteria isn't matched" do
        @dayhome_1.availability_types << @full_time_full_days
        @dayhome_1.certification_types << @level_1

        @dayhome_2.availability_types << @part_time_morning
        @dayhome_2.certification_types << @basic_cpr

        @params = { :advanced_search => 'true',
                    :availability_types => { :kind => [@part_time_morning.id.to_s ]},
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
        @dayhome_1.availability_types << @full_time_full_days
        @dayhome_1.availability_types << @part_time_morning

        @params = { :dietary_accommodations => '0',
                    :availability_types => { :kind => [@part_time_morning.id.to_s ]},
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

    describe "licensed pins" do
      it "where 1 dayhome is returned if licensed is checked" do
        @params = { :license_group => 'licensed',
                    :advanced_search => 'true' }

        valid_search = Search.new(@params)
        valid_search.pin_count.should eql(1)
      end

      it "where 1 dayhome is returned if unlicensed is checked" do
        @params = { :license_group => 'unlicensed',
                    :advanced_search => 'true' }

        valid_search = Search.new(@params)
        valid_search.pin_count.should eql(1)
      end

      it "where 2 dayhomes are returned if both are checked" do
        @params = { :license_group => 'both_license_types',
                    :advanced_search => 'true' }

        valid_search = Search.new(@params)
        valid_search.pin_count.should eql(2)
      end

      it "where 1 dayhome is returned if licesed and an availability type are checked" do
        @dayhome_1.availability_types << @full_time_full_days
        @dayhome_1.availability_types << @part_time_morning

        @params = { :license_group => 'licensed',
                    :availability_types => { :kind => [@part_time_morning.id.to_s ]},
                    :advanced_search => 'true' }

        valid_search = Search.new(@params)
        valid_search.pin_count.should eql(1)
      end
    end

  end
end
