#encoding: utf-8 
namespace :db do
  namespace :reset do
    task :samples => :environment do
      Rake::Task["db:reset"].invoke
      Rake::Task["db:seed"].invoke
      Rake::Task["db:seed:samples"].invoke
    end
  end

  namespace :seed do
    task :samples => :environment do
      def add_photos_to_dayhome(photos, day_home)
        puts "Adding photos to #{day_home.name}..."
        photos.map do |photo|
          photo[:photo] = File.open(File.dirname(__FILE__) + "/seeds/dayhomes/" + photo[:photo]) unless photo[:photo].respond_to?(:read)
          photo
        end
        default=true
        photos.each do |photo|
          day_home_photo=day_home.photos.create!(photo)
          day_home_photo.default_photo=default
          day_home_photo.save
          default=false
        end
      end
      debugger
      # Vonn sample
      org = Organization.create!({:name=>"Von Kids",:postal_code => 'T3G 1L4', :street1 => '159 Ranch Estates Rd NW',:city=>'Calgary',:province=>'Alberta',:plan=>'papa'})
      agencyUser1 =User.find_by_email('peter@voncreative.com')
      agencyUser2 =User.find_by_email('test@voncreative.com')
      if(agencyUser1.nil?)
        agencyUser1 = User.create!({:email => 'peter@voncreative.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'Peter', :last_name => 'Fuerbringer', :admin => false})
      end
      if(agencyUser2.nil?)
        agencyUser2 = User.create!({:email => 'test@voncreative.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'Brenda', :last_name => 'Schuler', :admin => false})
      end
      org.users << agencyUser1
      org.users << agencyUser2
      location = Location.create!({:name=>"Calgary"})
      org.locations<<location
      org.save
      
      # get certification types
      level_1 = CertificationType.where({:kind => 'Child Care Level 1'}).first
      level_2 = CertificationType.where({:kind => 'Child Care Level 2'}).first
      level_3 = CertificationType.where({:kind => 'Child Care Level 3'}).first
      basic_cpr = CertificationType.where({:kind => 'Basic First Aid'}).first
      advanced_cpr = CertificationType.where({:kind => 'Advanced First Aid'}).first
      infant_cpr = CertificationType.where({:kind => 'Infant CPR'}).first

      # get availability types
      full_time_full_days = AvailabilityType.where({:availability => 'Full-time', :kind => 'Full Days'}).first
      full_time_after_school = AvailabilityType.where({:availability => 'Full-time', :kind => 'After School'}).first
      full_time_before_school = AvailabilityType.where({:availability => 'Full-time', :kind => 'Before School'}).first
      part_time_full_days = AvailabilityType.where({:availability => 'Part-time', :kind => 'Full Days'}).first
      part_time_morning = AvailabilityType.where({:availability => 'Part-time', :kind => 'Morning'}).first
      part_time_afternoon = AvailabilityType.where({:availability => 'Part-time', :kind => 'Afternoon'}).first
      part_time_after_school = AvailabilityType.where({:availability => 'Part-time', :kind => 'After School'}).first
      part_time_before_school = AvailabilityType.where({:availability => 'Part-time', :kind => 'Before School'}).first


      fulltime_addresses = [
          {:postal_code => 'T3A 5P2', :street1 => '107 Hampstead Cir NW'},
          {:postal_code => 'T2P 1J5', :street1 => '1100 8 Ave SW'},
          {:postal_code => 'T2A 4H8', :street1 => '1115 Marcombe Cres NE'},
          {:postal_code => 'T3J 1Y8', :street1 => '116 Castleridge Dr NE'},
          {:postal_code => 'T3K 3Z2', :street1 => '116 Country Hills Close NW'},
          {:postal_code => 'T3K 5L8', :street1 => '118 Panamount Cres NW'},
          {:postal_code => 'T3G 4X5', :street1 => '12 Royal Terr NW'},
          {:postal_code => 'T3K 2E9', :street1 => '120 Bernard Way NW'},
          {:postal_code => 'T2G 5G4', :street1 => '122 3 Ave SE'},
          {:postal_code => 'T2E 1B6', :street1 => '130 13 Ave NE'},
          {:postal_code => 'T3G 1N2', :street1 => '1455 Ranchlands Rd NW'},
          {:postal_code => 'T3G 2Z9', :street1 => '152 Hawkdale Close NW'},
          {:postal_code => 'T3G 1L4', :street1 => '159 Ranch Estates Rd NW'},
          {:postal_code => 'T2E 8S7', :street1 => '1623 Centre St NW'},
          {:postal_code => 'T3H 3V1', :street1 => '18 Spring Cres SW'},
          {:postal_code => 'T3H 5M8', :street1 => '183 Springborough Way SW'},
          {:postal_code => 'T3K 2A9', :street1 => '196 Bermuda Dr NW'},
          {:postal_code => 'T3H 1E6', :street1 => '20 Coachway Rd SW'},
          {:postal_code => 'T2P 1M3', :street1 => '200 1 St SW'},
          {:postal_code => 'T2B 0W9', :street1 => '2012 35 St SE'},
          {:postal_code => 'T2E 2C2', :street1 => '221 29 Ave NE'},
          {:postal_code => 'T2E 4E7', :street1 => '223 7a St NE'},
          {:postal_code => 'T3A 5N3', :street1 => '246 Hidden Spring Mews NW'},
          {:postal_code => 'T3A 5Y6', :street1 => '250 Hampstead Gdns NW'},
          {:postal_code => 'T3H 2V1', :street1 => '2876 Signal Hill Dr SW'},
          {:postal_code => 'T2W 3V9', :street1 => '296 Woodfield Rd SW'},
          {:postal_code => 'T2Z 4E8', :street1 => '314 McKenzie Towne Link SE'},
          {:postal_code => 'T3A 2C6', :street1 => '3302 50 St NW'},
          {:postal_code => 'T1Y 6V5', :street1 => '36 Del Ray Rd NE'},
          {:postal_code => 'T2Z 3C3', :street1 => '3757 Douglas Ridge Way SE'},
          {:postal_code => 'T3K 0C6', :street1 => '38 Panamount Row NW'},
          {:postal_code => 'T2L 1G8', :street1 => '3812 Brighton Dr NW'},
          {:postal_code => 'T2K 0X8', :street1 => '4305 1a St NW'},
          {:postal_code => 'T3K 5N5', :street1 => '44 Panorama Hills Heath NW'},
          {:postal_code => 'T3A 6N6', :street1 => '4729 Hamptons Way NW'},
          {:postal_code => 'T2E 0X6', :street1 => '540 10 Ave NE'},
          {:postal_code => 'T3A 1E6', :street1 => '5812 Dalmead Cres NW'},
          {:postal_code => 'T1Y 2C3', :street1 => '5822 Rundlehorn Dr NE'},
          {:postal_code => 'T3H 2R3', :street1 => '7020 Christie Briar Manor SW'},
          {:postal_code => 'T2K 5B6', :street1 => '7379 Huntington St NE'},
          {:postal_code => 'T3K 4Y6', :street1 => '74 Country Hills Hts NW'},
          {:postal_code => 'T2K 4P8', :street1 => '7827 Hunterview Dr NW'},
          {:postal_code => 'T3H 5S1', :street1 => '7981 Cougar Ridge Ave SW'},
          {:postal_code => 'T1Y 6R2', :street1 => '8 Del Monica Bay NE'},
          {:postal_code => 'T2S 0S1', :street1 => '803 Rideau Rd SW'},
          {:postal_code => 'T3K 5R4', :street1 => '84 Covepark Close NE'}]

      full_time_names = [
          'Ingle Dayhome',
          'Penley Dayhome',
          'Harber Dayhome',
          'Chapell Dayhome',
          'Peffer Dayhome',
          'Baskerville Dayhome',
          'Wehling Dayhome',
          'Neuhaus Dayhome',
          'Bundrick Dayhome',
          'Myatt Dayhome',
          'Klippel Dayhome',
          'Tippie Dayhome',
          'Heft Dayhome',
          'Pajak Dayhome',
          'Dasilva Dayhome',
          'Bame Dayhome',
          'Rado Dayhome',
          'Stfleur Dayhome',
          'Joplin Dayhome',
          'Trybus Dayhome',
          'Schleusner Dayhome',
          'Groesbeck Dayhome',
          'Mealy Dayhome',
          'Stull Dayhome',
          'Hannaford Dayhome',
          'Reiling Dayhome',
          'Cuomo Dayhome',
          'Dilday Dayhome',
          'Podkowka Dayhome',
          'Manalo Dayhome',
          'Miltenberger Dayhome',
          'Sachs Dayhome',
          'Hertzog Dayhome',
          'Squire Dayhome',
          'Pechacek Dayhome',
          'Tatham Dayhome',
          'Bierman Dayhome',
          'Bergan Dayhome',
          'Baumer Dayhome',
          'Uhl Dayhome',
          'Buelow Dayhome',
          'Deshaies Dayhome',
          'Loewen Dayhome',
          'Roane Dayhome',
          'Ventura Dayhome',
          'Carrington Dayhome',
      ]
      dummy_text = [
          "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean.",
          "A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth.",
          "Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar.",
          "The Big Oxmox advised her not to do so, because there were thousands of bad Commas, wild Question Marks and devious Semikoli, but the Little Blind Text didn't listen. She packed her seven versalia, put her initial into the belt and made herself on the way.",
          "When she reached the first hills of the Italic Mountains, she had a last view back on the skyline of her hometown Bookmarksgrove, the headline of Alphabet Village and the subline of her own road, the Line Lane."
      ]
      photos = [
          { :caption => "Tasty snacks.", :photo => "cereal.jpg"},
          { :caption => "We provide arts and crafts.", :photo => "crafts.jpg"},
          { :caption => "Activities for all ages.", :photo => "finger_painting.jpg"},
          { :caption => "Healthy food alternatives.", :photo => "fruit_salad.jpg" }
      ]
      fulltime_addresses.each_with_index  do |street_and_postal, index|
        
        d = DayHome.create!({:name => full_time_names[index],
                             :gmaps =>  true,
                             :city =>  'Calgary',
                             :province =>  'AB',
                             :street2 =>  '',
                             :slug => "DayHome#{Date.today.year+Date.today.month+Date.today.day+index}single",
                             :email => "dh#{index}@voncreative.com",
                             #:featured => true,
                             :phone_number => '780-555-5555',
                             :highlight => full_time_names[index]+" is a terrific place for children to learn and have fun. With all sorts of activities in store, kids love it.",
                             :blurb => dummy_text[1+Random.rand(4)]+"\n\n"+dummy_text[1+Random.rand(4)]+"\n\n"+dummy_text[1+Random.rand(4)]+"\n\n"
                            }.merge(street_and_postal))

        d.availability_types << full_time_full_days
        d.certification_types << level_1
        d.certification_types << level_2
        d.certification_types << advanced_cpr
        if index.odd?
          d.licensed = true
          d.availability_types << part_time_after_school
          d.certification_types << level_3
          d.certification_types << infant_cpr
        end
        add_photos_to_dayhome(photos, d)
        location.day_homes << d
        location.save
      end

    end
    # task :samples_old => :environment do
    #   # create plans
    #   baby = Plan.create!({:name=>"Baby Bear",:plan=>"baby",:day_homes=>1, :staff=>0,:locales=>1,:price=>0.00,:block_staff_addon=>1,:block_locales_addon=>1, :active=>Time.now})
    #   mama= Plan.create!({:name=>"Mama Bear",:plan=>"mama",:day_homes=>50, :staff=>1,:locales=>1,:price=>50.00,:block_staff_addon=>0,:block_locales_addon=>1, :active=>Time.now, :free_features => 1})
    #   papa=Plan.create!({:name=>"Papa Bear",:plan=>"papa",:day_homes=>250, :staff=>2,:locales=>5,:price=>250.00,:block_staff_addon=>0,:block_locales_addon=>0, :active=>Time.now, :free_features => 5})
    #   goldilocks=Plan.create!({:name=>"Goldilocks",:plan=>"goldilocks",:day_homes=>-1, :staff=>3,:locales=>-1,:price=>400.00,:block_staff_addon=>0,:block_locales_addon=>0, :active=>Time.now, :free_features => 8})

    #   # create certification types
    #   level_1 = CertificationType.where({:kind => 'Child Care Level 1'}).first
    #   level_2 = CertificationType.where({:kind => 'Child Care Level 2'}).first
    #   level_3 = CertificationType.where({:kind => 'Child Care Level 3'}).first
    #   basic_cpr = CertificationType.where({:kind => 'Basic First Aid'}).first
    #   advanced_cpr = CertificationType.where({:kind => 'Advanced First Aid'}).first
    #   infant_cpr = CertificationType.where({:kind => 'Infant CPR'}).first

    #   # create availability types
    #   full_time_full_days = AvailabilityType.where({:availability => 'Full-time', :kind => 'Full Days'}).first
    #   full_time_after_school = AvailabilityType.where({:availability => 'Full-time', :kind => 'After School'}).first
    #   full_time_before_school = AvailabilityType.where({:availability => 'Full-time', :kind => 'Before School'}).first
    #   part_time_full_days = AvailabilityType.where({:availability => 'Part-time', :kind => 'Full Days'}).first
    #   part_time_morning = AvailabilityType.where({:availability => 'Part-time', :kind => 'Morning'}).first
    #   part_time_afternoon = AvailabilityType.where({:availability => 'Part-time', :kind => 'Afternoon'}).first
    #   part_time_after_school = AvailabilityType.where({:availability => 'Part-time', :kind => 'After School'}).first
    #   part_time_before_school = AvailabilityType.where({:availability => 'Part-time', :kind => 'Before School'}).first

    #   review_1 = Review.new({:content => 'Bacon ipsum dolor sit amet tri-tip pancetta cow kielbasa. Shank jerky meatloaf, kielbasa sirloin chuck jowl frankfurter swine boudin shoulder pastrami. Bresaola ham kielbasa, meatloaf tri-tip jowl tongue filet mignon flank ball tip brisket andouille. Filet mignon boudin t-bone swine turkey ball tip.', :rating => 2})
    #   review_2 = Review.new({:content => 'Meatloaf short loin shankle tri-tip. Tri-tip swine turducken pork, filet mignon flank ribeye ball tip jowl. Tongue hamburger short ribs, jowl spare ribs filet mignon chuck t-bone. Sirloin ham boudin, pancetta pork loin drumstick ground round shank capicola chuck corned beef strip steak swine venison.', :rating => 1})
    #   review_3 = Review.new({:content => 'Salami pork capicola prosciutto tri-tip biltong, shank chuck pig corned beef pancetta fatback jowl. Swine shank speck pancetta, salami jowl spare ribs cow tri-tip shankle ground round. Spare ribs meatball pork, jerky strip steak short loin speck bresaola kielbasa beef pork loin. Bacon turducken chicken ham pancetta pork belly, beef ribs shank capicola sirloin boudin short loin frankfurter shoulder.', :rating => 5})
    #   review_4 = Review.new({:content => 'Meatball turducken filet mignon shankle, frankfurter pig short loin brisket rump pork chop. Chicken bacon salami filet mignon corned beef bresaola, ball tip beef ribs meatball. Bacon pork belly sausage, salami t-bone tri-tip shoulder strip steak ham speck jerky chuck pork brisket turducken.', :rating => 5})
    #   review_5 = Review.new({:content => 'Turkey tail ham hock venison, pancetta chicken jerky tri-tip rump ball tip beef ribs frankfurter jowl. Shank bresaola sausage, pork chop chicken chuck pancetta ham hock salami turkey brisket.', :rating => 3})
    #   review_6 = Review.new({:content => 'Speck spare ribs shoulder ground round prosciutto, bresaola venison turducken pork belly swine short loin. Jowl ball tip ground round, jerky pork belly venison prosciutto pancetta ham drumstick corned beef strip steak pork hamburger ham hock.', :rating => 0})
    #   review_7 = Review.new({:content => 'Pancetta speck ribeye, ham hock pork loin spare ribs brisket ball tip.', :rating => 1})

    #   reviews = [review_1, review_2, review_3, review_4, review_5, review_6, review_7]

    #   # Create Default Admin User
    #   admin_user = User.create!({:email => 'dayadmin@dayhomeregistry.com', :password => 'day4admin', :password_confirmation => 'day4admin', :first_name => 'DayHome', :last_name => 'Admin', :admin => true})
    #   user0 = User.create!({:email => 'test0@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'Marty', :last_name => 'Bristow', :admin => false})
    #   user1 = User.create!({:email => 'test1@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'Lestor', :last_name => 'Hart', :admin => false})
    #   user2 = User.create!({:email => 'test2@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'Betty', :last_name => 'Williams', :admin => false})
    #   user3 = User.create!({:email => 'test3@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'May', :last_name => 'Manweiler', :admin => false})
    #   user4 = User.create!({:email => 'test4@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'Marilyn', :last_name => 'Dennis', :admin => false})
    #   user5 = User.create!({:email => 'test5@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'Lisa', :last_name => 'Schreder', :admin => false})
    #   user6 = User.create!({:email => 'test6@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'Faye', :last_name => 'Morrison', :admin => false})

    #   users = [ user0, user1, user2, user3, user4, user5, user6]

    #   # Create basic agency
    #   org = Organization.create!({:name=>"Child Development Dayhomes",:postal_code => 'T5N1Y6', :street1 => '131 St NW',:city=>'Edmonton',:province=>'Alberta',:plan=>'papa'})
    #   agencyUser1 = User.create!({:email => 'agency1@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'Bobby', :last_name => 'Arya', :admin => false})
    #   agencyUser2 = User.create!({:email => 'agency2@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'Brenda', :last_name => 'Schuler', :admin => false})
    #   org.users << agencyUser1
    #   org.users << agencyUser2
    #   location = Location.create!({:name=>"Edmonton"})
    #   org.locations<<location
    #   org.save

    #   # address hashes
    #   fulltime_addresses = [
    #       {:postal_code => 'T5N1Y6', :street1 => '131 St NW'},
    #       {:postal_code => 'T5S1R5', :street1 => '178 St NW'},
    #       {:postal_code => 'T6C0P9', :street1 => '79 Avenue Northwest'},
    #       {:postal_code => 'T5E4E5', :street1 => '128 Avenue Northwest'},
    #       {:postal_code => 'T6E3J5'},
    #       {:postal_code => 'T6A7R6'},
    #       {:postal_code => 'T6F0F5'},
    #       {:postal_code => 'T5J2F6'},
    #       {:postal_code => 'T5W7H5'},
    #       {:postal_code => 'T6I2K6'},
    #       {:postal_code => 'T6X6Z5'},
    #       {:postal_code => 'T6Z1G5'},
    #       {:postal_code => 'T6P9D6'},
    #       {:postal_code => 'T6G0I5'},
    #       {:postal_code => 'T5X8W6'},
    #       {:postal_code => 'T5G4A5'},
    #       {:postal_code => 'T6P8X5'},
    #       {:postal_code => 'T5X5I6'},
    #       {:postal_code => 'T5D2J5'},
    #       {:postal_code => 'T5I3D5'},
    #       {:postal_code => 'T6V1C5'},
    #       {:postal_code => 'T5X3S6'},
    #       {:postal_code => 'T6Y9Y6'},
    #       {:postal_code => 'T5J7X5'},
    #       {:postal_code => 'T6H0O6'},
    #       {:postal_code => 'T5D1U6'},
    #       {:postal_code => 'T5Y0Z5'},
    #       {:postal_code => 'T5N2J5'},
    #       {:postal_code => 'T6X5W5'},
    #       {:postal_code => 'T5L0Z6'},
    #       {:postal_code => 'T6Z2J5'},
    #       {:postal_code => 'T6F3H6'},
    #       {:postal_code => 'T6H1H6'},
    #       {:postal_code => 'T6D5K5'},
    #       {:postal_code => 'T6W3C5'},
    #       {:postal_code => 'T6O1B6'},
    #       {:postal_code => 'T6C2I5'},
    #       {:postal_code => 'T5P9M5'},
    #       {:postal_code => 'T6C8U5'},
    #       {:postal_code => 'T6E8W5'},
    #       {:postal_code => 'T5D4Q6'},
    #       {:postal_code => 'T5Z4J5'},
    #       {:postal_code => 'T5B0O6'},
    #       {:postal_code => 'T5N4W6'},
    #       {:postal_code => 'T6B1D6'},
    #       {:postal_code => 'T6Y1W5'},
    #       {:postal_code => 'T6H4I6'},
    #       {:postal_code => 'T6L8S6'},
    #       {:postal_code => 'T6Y0Z5'},
    #       {:postal_code => 'T5K0R6'},
    #       {:postal_code => 'T6P1A5'},
    #       {:postal_code => 'T6Z9N5'},
    #       {:postal_code => 'T6B9E6'},
    #       {:postal_code => 'T6P9Q6'},
    #       {:postal_code => 'T6Y3J6'},
    #       {:postal_code => 'T6F2Q6'},
    #       {:postal_code => 'T6E0I5'},
    #       {:postal_code => 'T6N6A5'},
    #       {:postal_code => 'T5H5C6'},
    #       {:postal_code => 'T5L4I6'},
    #       {:postal_code => 'T5I9R5'},
    #       {:postal_code => 'T6B7O5'},
    #       {:postal_code => 'T5C8T6'},
    #       {:postal_code => 'T5X5G5'},
    #       {:postal_code => 'T6P1W6'},
    #       {:postal_code => 'T5H2R5'},
    #       {:postal_code => 'T6H9E6'},
    #       {:postal_code => 'T6N8K6'},
    #       {:postal_code => 'T6B5C5'},
    #       {:postal_code => 'T5X2Y6'},
    #       {:postal_code => 'T6S8C6'},
    #       {:postal_code => 'T6G6O5'},
    #       {:postal_code => 'T5A0C5'},
    #       {:postal_code => 'T5W6X6'},
    #       {:postal_code => 'T5T3E5'},
    #       {:postal_code => 'T6J2A6'},
    #       {:postal_code => 'T6V4V5'},
    #       {:postal_code => 'T6Z8Q6'},
    #       {:postal_code => 'T6Z0K6'},
    #       {:postal_code => 'T6E5P6'},
    #       {:postal_code => 'T5A5V6'},
    #       {:postal_code => 'T6E2N6'},
    #       {:postal_code => 'T6M2M6'},
    #       {:postal_code => 'T6L7N5'},
    #       {:postal_code => 'T6K3L5'},
    #       {:postal_code => 'T6T8D5'},
    #       {:postal_code => 'T6R6L6'},
    #       {:postal_code => 'T5Q7Y6'},
    #       {:postal_code => 'T6F1N6'},
    #       {:postal_code => 'T6D9H5'},
    #       {:postal_code => 'T5U7B5'},
    #       {:postal_code => 'T6S7Z5'},
    #       {:postal_code => 'T6Z6R6'},
    #       {:postal_code => 'T5U6K5'},
    #       {:postal_code => 'T6H8P5'},
    #       {:postal_code => 'T6T7V6'},
    #       {:postal_code => 'T6A3O5'},
    #       {:postal_code => 'T6D8X6'},
    #       {:postal_code => 'T6U4Y6'},
    #       {:postal_code => 'T5R5B5'},
    #       {:postal_code => 'T6U5T5'},
    #       {:postal_code => 'T5N2W5'},
    #       {:postal_code => 'T5Y9X5'},
    #       {:postal_code => 'T5P7N5'}
    #   ]

    #   part_time_addresses = [
    #       {:postal_code => 'T6W1C3', :street1 => '793 blackburn place'},
    #       {:postal_code => 'T6L5M6', :street1 => '4138 36st NW'}
    #   ]

    #   no_availability_addresses = [
    #       {:postal_code => 'T6J5M5', :street1 => '2978 106 Street NW'},
    #       {:postal_code => 'T5S1S5', :street1 => '10070 178 Street NW'}
    #   ]
    #   dummy_text = [
    #       "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean.",
    #       "A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth.",
    #       "Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar.",
    #       "The Big Oxmox advised her not to do so, because there were thousands of bad Commas, wild Question Marks and devious Semikoli, but the Little Blind Text didn't listen. She packed her seven versalia, put her initial into the belt and made herself on the way.",
    #       "When she reached the first hills of the Italic Mountains, she had a last view back on the skyline of her hometown Bookmarksgrove, the headline of Alphabet Village and the subline of her own road, the Line Lane."
    #   ]
    #   fulltime_names = [
    #       "Fanny fulltime",
    #       "Two bears fulltime",
    #       "Mayday fulltime",
    #       "Alternative fulltime",
    #       "Aardvark Dayhome",
    #       "Abase Dayhome",
    #       "Abate Dayhome",
    #       "Abbot Dayhome",
    #       "Abel Dayhome",
    #       "Abhorred Dayhome",
    #       "Abject Dayhome",
    #       "Ablest Dayhome",
    #       "Aboard Dayhome",
    #       "Aborts Dayhome",
    #       "Above Dayhome",
    #       "Abroad Dayhome",
    #       "Abscessed Dayhome",
    #       "Absent Dayhome",
    #       "Absolves Dayhome",
    #       "Abstain Dayhome",
    #       "Abuse Dayhome",
    #       "Accents Dayhome",
    #       "Acclaim Dayhome",
    #       "Accosts Dayhome",
    #       "Accrue Dayhome",
    #       "Accursed Dayhome",
    #       "Aces Dayhome",
    #       "Aching Dayhome",
    #       "Acing Dayhome",
    #       "Acorn Dayhome",
    #       "Aardvarks Dayhome",
    #       "Abased Dayhome",
    #       "Abates Dayhome",
    #       "Abbots Dayhome",
    #       "Abet Dayhome",
    #       "Abhors Dayhome",
    #       "Ablaze Dayhome",
    #       "Abloom Dayhome",
    #       "Abode Dayhome",
    #       "Abound Dayhome",
    #       "Abreast Dayhome",
    #       "Abrupt Dayhome",
    #       "Abscond Dayhome",
    #       "Absents Dayhome",
    #       "Absorb Dayhome",
    #       "Abstract Dayhome",
    #       "Abused Dayhome",
    #       "Accept Dayhome",
    #       "Accord Dayhome",
    #       "Account Dayhome",
    #       "Accrued Dayhome",
    #       "Accurst Dayhome",
    #       "Achieve Dayhome",
    #       "Achy Dayhome",
    #       "Acme Dayhome",
    #       "Acorns Dayhome",
    #       "Aaron Dayhome",
    #       "Abash Dayhome",
    #       "Abbey Dayhome",
    #       "Abduct Dayhome",
    #       "Abets Dayhome",
    #       "Abide Dayhome",
    #       "Able Dayhome",
    #       "Ably Dayhome",
    #       "Abodes Dayhome",
    #       "Abounds Dayhome",
    #       "Abridge Dayhome",
    #       "Abscam Dayhome",
    #       "Absconds Dayhome",
    #       "Absolve Dayhome",
    #       "Absorbed Dayhome",
    #       "Abstracts Dayhome",
    #       "Accede Dayhome",
    #       "Accepts Dayhome",
    #       "Accords Dayhome",
    #       "Accountants Dayhome",
    #       "Accrues Dayhome",
    #       "Accuse Dayhome",
    #       "Achieved Dayhome",
    #       "Acid Dayhome",
    #       "Acne Dayhome",
    #       "Aback Dayhome",
    #       "Abashed Dayhome",
    #       "Abbeys Dayhome",
    #       "Abducts Dayhome",
    #       "Abhor Dayhome",
    #       "Abides Dayhome",
    #       "Abler Dayhome",
    #       "Abner Dayhome",
    #       "Abort Dayhome",
    #       "About Dayhome",
    #       "Abridged Dayhome",
    #       "Abscess Dayhome",
    #       "Absence Dayhome",
    #       "Absolved Dayhome",
    #       "Absorbs Dayhome",
    #       "Absurd Dayhome",
    #       "Accent Dayhome",
    #       "Access Dayhome",
    #       "Accost Dayhome",
    #       "Accounts Dayhome",
    #       "Accurse Dayhome",
    #       "Accused Dayhome",
    #       "Achieves Dayhome"
    #   ]
    #   part_time_names = [
    #       "Patty part-time",
    #       "Chocolate part-time",
    #       "Mint part-time",
    #       "Butterscotch part-time"
    #   ]
    #   no_availability_names = [
    #       "Awesome All-full",
    #       "Penelope Plein"
    #   ]

    #   def add_photos_to_dayhome(photos, day_home)
    #     puts "Adding photos to #{day_home.name}..."
    #     photos.map do |photo|
    #       photo[:photo] = File.open(File.dirname(__FILE__) + "/seeds/dayhomes/" + photo[:photo]) unless photo[:photo].respond_to?(:read)
    #       photo
    #     end
    #     default=true
    #     photos.each do |photo|
    #       day_home_photo=day_home.photos.create!(photo)
    #       day_home_photo.default_photo=default
    #       day_home_photo.save
    #       default=false
    #     end
    #   end

    #   # Create a dayhome with reviews
    #   o1 = Organization.create!({:name=>"DayHome With Reviews",:postal_code => 'T6L5M6', :phone_number => '780-555-5555',:street1 => '4138 36st NW',:city=>'Edmonton',:province=>'Alberta'})
    #   l1 = Location.create!({:name=>"Edmonton"})
    #   agencyUser2.location = l1
    #   o1.locations << l1
    #   day_home_with_reviews = DayHome.create!({:name => "DayHome With Reviews",
    #                                            :gmaps =>  true,
    #                                            :city =>  'Edmonton',
    #                                            :province =>  'AB',
    #                                            :street1 => '4138 36st NW',
    #                                            :street2 =>  '',
    #                                            :slug => 'DayHomesWithReviews',
    #                                            :email => 'withreviews123@dayhomeregistry.com',
    #                                            :postal_code => 'T6L5M6',
    #                                            :highlight => 'Dayhome With Reviews is a terrific place for children to learn and have fun. With all sorts of activities in store, kids love it.',
    #                                            :blurb => 'Dayhome With Reviews is a terrific place for children to learn and have fun. With all sorts of activities in store, kids love it.'                                               
    #                                           })
    #   day_home_with_reviews.availability_types << full_time_full_days
    #   l1.day_homes << day_home_with_reviews
    #   o1.save
    #   l1.save
    #   photos = [
    #       { :caption => "Six and counting.", :photo => "counting.jpg"},
    #       { :caption => "We provide arts and crafts.", :photo => "crayons.jpg"},
    #       { :caption => "There are activities for all children.", :photo => "playdoe.jpg"},
    #       { :caption => "Outdoor playground", :photo => "swing.jpg" }
    #   ]
    #   add_photos_to_dayhome(photos, day_home_with_reviews)
    #   #feature this dayhome
    #   f1= Feature.create!({:start=>DateTime.now(),:end=>DateTime.now()+1.month, :day_home_id=>day_home_with_reviews.id,:organization_id=>o1.id,:freebee=>false})

    #   # add reviews to day_home_with_reviews
    #   reviews.each_with_index do |rev, index|
    #     rev.user = users[index]
    #     rev.day_home = day_home_with_reviews
    #     rev.save!
    #   end


    #   # Create a couple of dayhomes with full time
    #   photos = [
    #       { :caption => "Tasty snacks.", :photo => "cereal.jpg"},
    #       { :caption => "We provide arts and crafts.", :photo => "crafts.jpg"},
    #       { :caption => "Activities for all ages.", :photo => "finger_painting.jpg"},
    #       { :caption => "Healthy food alternatives.", :photo => "fruit_salad.jpg" }
    #   ]
    #   fulltime_addresses.each_with_index  do |street_and_postal, index|
        
    #     d = DayHome.create!({:name => fulltime_names[index],
    #                          :gmaps =>  true,
    #                          :city =>  'Edmonton',
    #                          :province =>  'AB',
    #                          :street2 =>  '',
    #                          :slug => "DayHome#{index}single",
    #                          :email => "dh564f#{index}@dayhomeregistry.com",
    #                          #:featured => true,
    #                          :phone_number => '780-555-5555',
    #                          :highlight => fulltime_names[index]+" is a terrific place for children to learn and have fun. With all sorts of activities in store, kids love it.",
    #                          :blurb => dummy_text[1+Random.rand(4)]+"\n\n"+dummy_text[1+Random.rand(4)]+"\n\n"+dummy_text[1+Random.rand(4)]+"\n\n"
    #                         }.merge(street_and_postal))

    #     d.availability_types << full_time_full_days
    #     d.certification_types << level_1
    #     d.certification_types << level_2
    #     d.certification_types << advanced_cpr
    #     if index.odd?
    #       d.licensed = true
    #       d.availability_types << part_time_after_school
    #       d.certification_types << level_3
    #       d.certification_types << infant_cpr
    #     end
    #     add_photos_to_dayhome(photos, d)
    #     location.day_homes << d
    #     location.save
    #   end

    #   # Create a couple of dayhomes with part time
    #   photos = [
    #       { :caption => "Fun all day long", :photo => "laughing_outside.jpg" },
    #       { :caption => "Group activities", :photo => "playing_kids.jpg" },
    #       { :caption => "Homemade lunches", :photo => "mac_and_cheese.jpg" },
    #       { :caption => "Stimulating activities.", :photo => "lego.jpg" },
    #   ]
    #   part_time_addresses.each_with_index  do |street_and_postal, index|
    #     o = Organization.create!({:name=>part_time_names[index]}.merge(street_and_postal))
    #     l = Location.create!({:name=>"Edmonton"})
    #     o.locations << l
    #     d = DayHome.create!({:name => part_time_names[index],
    #                          :gmaps =>  true,
    #                          :city =>  'Edmonton',
    #                          :province =>  'AB',
    #                          :street2 =>  '',
    #                          :slug => "DayHome#{index}partime",
    #                          :email => "dh32p#{index}@dayhomeregistry.com",
    #                          :phone_number => '17809062943',
    #                          :featured => true,
    #                          :highlight => part_time_names[index]+" is a terrific place for children to learn and have fun. With all sorts of activities in store, kids love it.",
    #                          :blurb => dummy_text[1+Random.rand(4)]+"\n"+dummy_text[1+Random.rand(4)]+"\n"+dummy_text[1+Random.rand(4)]+"\n"                             
    #                         }.merge(street_and_postal))
    #     d.availability_types << part_time_morning
    #     d.certification_types << basic_cpr
    #     if index.odd?
    #       d.licensed = true
    #       d.availability_types << part_time_afternoon
    #     end
    #     add_photos_to_dayhome(photos, d)
    #     l.day_homes << d
    #     o.save
    #     l.save
    #     d.save
    #   end

    #   # Create a couple of dayhomes with no availability
    #   no_availability_addresses.each_with_index  do |street_and_postal, index|
    #     o = Organization.create!({:name=>no_availability_names[index]}.merge(street_and_postal))
    #     l = Location.create!({:name=>"Edmonton"})
    #     o.locations << l
    #     d = DayHome.create!({:name => no_availability_names[index],
    #                          :gmaps =>  true,
    #                          :city =>  'Edmonton',
    #                          :province =>  'AB',
    #                          :street2 =>  '',
    #                          :slug => "DayHome#{index}noavail",
    #                          :phone_number => '17809062942',
    #                          :email => "dhn#{index}@dayhomeregistry.com",
    #                          :highlight => no_availability_names[index]+" is a terrific place for children to learn and have fun. With all sorts of activities in store, kids love it.",
    #                          :blurb => dummy_text[1+Random.rand(4)]+"\n"+dummy_text[1+Random.rand(4)]+"\n"+dummy_text[1+Random.rand(4)]+"\n"                                                          
    #                         }.merge(street_and_postal))
    #     d.availability_types << part_time_before_school
    #     d.availability_types << full_time_after_school
    #     d.certification_types << advanced_cpr
    #     if index.odd?
    #       d.availability_types << part_time_full_days
    #       d.dietary_accommodations = true
    #       d.save!
    #     end
    #     l.day_homes << d
    #     o.save
    #     l.save
    #     d.save        
    #   end

    #   # create a user related to a dayhome
    #   first_day_home = DayHome.first
    #   user_related_to_dayhome = User.create!({:email => 'dayhomeadmin@dayhomes.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'dayhome', :last_name => 'admin', :admin => false})
    #   user_related_to_dayhome.day_homes << first_day_home

    #   # create events for the above dayhome
    #   Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now - 3, :ends_at => DateTime.now - 2, :all_day => false, :day_home_id => first_day_home.id })
    #   Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now - 3, :ends_at => DateTime.now - 2 + 3.hours, :all_day => false, :day_home_id => first_day_home.id })
    #   Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now, :ends_at => DateTime.now + 3, :all_day => false, :day_home_id => first_day_home.id })
    #   Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now, :ends_at => DateTime.now + 1, :all_day => false, :day_home_id => first_day_home.id })
    #   Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now + 3.hours, :ends_at => DateTime.now + 5.hours, :all_day => false, :day_home_id => first_day_home.id })
    #   Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now + 6.hours, :ends_at => DateTime.now + 8.hours, :all_day => false, :day_home_id => first_day_home.id })
    #   Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now + 5, :ends_at => DateTime.now + 8, :all_day => false, :day_home_id => first_day_home.id })
    #   Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now + 10, :ends_at => DateTime.now + 11, :all_day => false, :day_home_id => first_day_home.id })
    #   Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now + 10 + 3.hours, :ends_at => DateTime.now + 12, :all_day => false, :day_home_id => first_day_home.id })
    #   Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now + 10 + 7.hours, :ends_at => DateTime.now + 12, :all_day => false, :day_home_id => first_day_home.id })
    #   Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now, :ends_at => DateTime.now + 20, :all_day => false, :day_home_id => first_day_home.id })

    #   # forum seed data
    #   #create the categories
    #   cat_day = Category.create!({:title => 'Dayhomes', :position => 0})
    #   cat_nut = Category.create!({:title => 'Nutrition', :position => 0})
    #   cat_act = Category.create!({:title => 'Activities', :position => 0})

    #   #create the forums under each category
    #   main_forum = Forum.create!({:category_id => cat_day.id, :title => 'General Discussion', :position => 0, :description => 'Chat about your dayhome!'})
    #   nutrition_age_0 = Forum.create!({:category_id => cat_nut.id, :title => 'Age 0 - 1', :position => 0, :description => 'Discuss meals & snacks for ages 0 - 1'})
    #   Forum.create!({:category_id => cat_nut.id, :title => 'Age 1 - 2', :position => 0, :description => 'Discuss meals & snacks for ages 1 - 0'})
    #   Forum.create!({:category_id => cat_act.id, :title => 'Morning', :position => 0, :description => 'What activities do you do during the morning?'})
    #   Forum.create!({:category_id => cat_act.id, :title => 'Recess', :position => 0, :description => 'What activities do you do during recess?'})
    #   Forum.create!({:category_id => cat_act.id, :title => 'Afternoon', :position => 0, :description => 'What activities do you do during the afternoon?'})

    #   # create some forum topics
    #   t0 = Topic.new({:title => '(Sticky) Items that should be banned?', :sticky => true,  :locked => false, :body => 'Does anyone have a list of banned items for parents?'})
    #   t0.forum = main_forum
    #   t0.user = user_related_to_dayhome
    #   t0.save!

    #   t1 = Topic.new({:title => 'Where do you put your shoes?', :sticky => false,  :locked => false, :body => 'On a rack??'})
    #   t1.forum = main_forum
    #   t1.user = user_related_to_dayhome
    #   t1.save!

    #   t2 = Topic.new({:title => 'Allergic reaction scare!', :sticky => false,  :locked => false, :body => "Don't buy special brand bars! Have nuts!!!"})
    #   t2.forum = nutrition_age_0
    #   t2.user = user_related_to_dayhome
    #   t2.save!

    #   # create some responses to the above topics
    #   p1 = Post.new({:body => "Here's a list of banned items we have: knives, sharp pens, gameboys."})
    #   p1.forum = main_forum
    #   p1.user = user_related_to_dayhome
    #   p1.topic = t0
    #   p1.save!

    #   # create some responses to the above topics
    #   p1 = Post.new({:body => "We've had to ban lead covered toys and pens."})
    #   p1.forum = main_forum
    #   p1.user = user_related_to_dayhome
    #   p1.topic = t0
    #   p1.save!

    #   # create some responses to the above topics
    #   p1 = Post.new({:body => "We store them in a closet and have a child have an ID."})
    #   p1.forum = main_forum
    #   p1.user = user_related_to_dayhome
    #   p1.topic = t1
    #   p1.save!
    #   puts "Dev/Test Seed Complete"
    # end
  end
end