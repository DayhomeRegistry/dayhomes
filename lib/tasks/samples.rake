#encoding: utf-8 
namespace :db do
  namespace :reset do
    task :samples => :environment do
      Rake::Task["db:reset"].invoke
      Rake::Task["db:seed"].invoke
      Rake::Task["db:seed:voncreative"].invoke
      Rake::Task["db:seed:samples"].invoke
    end
  end

  namespace :seed do
    task :childsworld => :environment do
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
      photos = [
          { :caption => "It's a Child's World", :photo => "itsachildsworld_500x151.jpg"}
      ]
      # get certification types
      level_1 = CertificationType.where({:kind => 'Child Care Level 1'}).first
      crc = CertificationType.where({:kind => 'Criminal Record Check'}).first
      cwc = CertificationType.where({:kind => 'Child Welfare Check'}).first

      # get availability types
      full_time_full_days = AvailabilityType.where({:availability => 'Full-time', :kind => 'Full Days'}).first


      org = Organization.find_by_id(471)
      location = Location.find_by_id(468)

      d = DayHome.create!({:name => 'Gladys\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'11540 141 St ',:slug => 'Gladys'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Gladys is a member of It\'s a Child\'s World Agency', :blurb => 'Will do extended hours until 9 PM. Has a great playroom, crafts done oncea week, and lots of outside summer backyward playtimewill care for all ages ',:postal_code=>'T5M 1T6'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Atiya\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'11444 St Albert ',:slug => 'Atiya'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Atiya is a member of It\'s a Child\'s World Agency', :blurb => '',:postal_code=>'T5M 3L5'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Fatima\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'231 Cairns Place ',:slug => 'Fatima'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Fatima is a member of It\'s a Child\'s World Agency', :blurb => 'Will take children of all ages has pet birds and great homeset up. ',:postal_code=>'T6V 1M5'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Gayatri\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'13419 158 Ave ',:slug => 'Gayatri'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Gayatri is a member of It\'s a Child\'s World Agency', :blurb => 'Will take all ages, lots of nature walks and loves to teach children about natureand animals',:postal_code=>'T6V 1R6'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Noreen\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'10624 183 Ave ',:slug => 'Noreen'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Noreen is a member of It\'s a Child\'s World Agency', :blurb => 'Will drive to Dunlace or Badryn areas. Wll do evenings and overnight care',:postal_code=>'T5X 6G5'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Fareena\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'247 Primrose Gardens ',:slug => 'Fareena'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Fareena is a member of It\'s a Child\'s World Agency', :blurb => 'Will take all ages. Will workextended hours and weekendswill care for special needs ',:postal_code=>'T5T 0R1'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Rima\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'9524 148 Street ',:slug => 'Rima'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Rima is a member of It\'s a Child\'s World Agency', :blurb => 'Takes children of all ages Will do extended hoursGreat play area, always interacting with children, very loving and caring home. Willwalk to Crestwood school, will care for special needs ',:postal_code=>'T5N 3E4'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Kari\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'18324 76 Ave ',:slug => 'Kari'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Kari is a member of It\'s a Child\'s World Agency', :blurb => 'Will take all ages. Fully equipped playroom, songs, dancing, circle time, outsideplay, crafts, games, music, math and science',:postal_code=>'T5T 2L5'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Firdous and Asima\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'8731 179 Street ',:slug => 'Firdous and Asima'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Firdous and Asima are a member of It\'s a Child\'s World Agency', :blurb => 'Will drive to schools Accepts all ages. Great playroom with lots of choices for children toplay and explore. Provides greatmeals and snacks',:postal_code=>'T5T 0X4'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Tasneem\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'12406 112 Ave ',:slug => 'Tasneem'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Tasneem is a member of It\'s a Child\'s World Agency', :blurb => 'Will do Sat and eveningsAccepts all ages. Goes topark daily. Excellent, developmentalyencouraging program. ',:postal_code=>'T5M 2S9'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Leanne\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'3 Erin Close ',:slug => 'Leanne'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Leanne is a member of It\'s a Child\'s World Agency', :blurb => '1 Dog baking, crafts, and field tripsWill care for minor special needs',:postal_code=>'T8N 7J8'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Nikki\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'56 Grandin Village ',:slug => 'Nikki'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Nikki is a member of It\'s a Child\'s World Agency', :blurb => '1 Dog. Great playroom with lotsof centers, great dress up area,daily outside play, dancing singing,story time and crafts. Will take all ages of children.',:postal_code=>'T8N 1R9'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Tammy\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'14508 77 Street ',:slug => 'Tammy'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Tammy is a member of It\'s a Child\'s World Agency', :blurb => 'Only school age children Transports to schoolsGreat playroom with games,crafts, learning activites, lotsof field trips and outdoor play,science and math. Provider previously owned her own daycare.',:postal_code=>'T5C 1E8'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Adalia\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'9540 178 Street',:slug => 'Adalia'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Adalia is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages ',:postal_code=>'T5Z 2E4'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Crystal\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'8104 122 Ave ',:slug => 'Crystal'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Crystal is a member of It\'s a Child\'s World Agency', :blurb => 'Availible Evenings andWeekends. Accepts all ages1 dog, 1 cat. Great playroom, baking, arts and crafts,reading,writing and full learning program',:postal_code=>'T5B 4L5'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Edith\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'11625 81 Street ',:slug => 'Edith'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Edith is a member of It\'s a Child\'s World Agency', :blurb => 'Will open until 8PMNo weekends Former teacher',:postal_code=>'T5B 2S1'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Bonnie\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'3927 164 Ave',:slug => 'Bonnie'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Bonnie is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages. Can do evenings. One cat. Excellent home with great feildtrips and activites such as basic sign language,picnics, beading and scrapbooking. Willcare for special needs and transport toschools. ',:postal_code=>'T5Y 0M6'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Gurpinder\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'2420 146 Ave ',:slug => 'Gurpinder'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Gurpinder is a member of It\'s a Child\'s World Agency', :blurb => 'Great with children of all ages.Very caring interactive home.',:postal_code=>'T5Y 1W3'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Keltouma\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'12204 131 A Ave ',:slug => 'Keltouma'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Keltouma is a member of It\'s a Child\'s World Agency', :blurb => 'Takes special needs childrenBaking and field trips',:postal_code=>'T5L 3N8'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Irma\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'8810 163 St',:slug => 'Irma'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Irma is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages. Great playroom Provider loves doing arts and crafts,storytime, talking and teaching children new skills.',:postal_code=>'T5R 2N9'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Wanda\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'16706 90 Ave ',:slug => 'Wanda'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Wanda is a member of It\'s a Child\'s World Agency', :blurb => 'Will only take preschool(ages 3-5) 2 cats ',:postal_code=>'T5R 4X1'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Ester\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'8611 177A St',:slug => 'Ester'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Ester is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages and likes a full dayhome. Loves babies,verysoft spoken and caring. Lots of playing, dancing, and outside funWill take behaviour special needsnot physical.',:postal_code=>'T5T 0V7'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Cheryl\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'18404 89 Ave ',:slug => 'Cheryl'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Cheryl is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages and likes a fulldayhome. Full day programmingincluding, dancing, singing, crafts,reading, circle time',:postal_code=>'T5T 1N5'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Clarita\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'7319 183 B Street ',:slug => 'Clarita'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Clarita is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages and likes a fulldayhome. Religious loving home, very family friendly, makes children feel like part of the family. ',:postal_code=>'T5T 3Y8'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Chandra\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'18408 93 Ave ',:slug => 'Chandra'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Chandra is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages and likes a full dayhome. Baking, dancing, singing, walks, weekly themedprogram is followed and based on childrens intrests. ',:postal_code=>'T5T 1P6'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Debbie\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'5131 191 Street',:slug => 'Debbie'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Debbie is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages. Fulltime only2 dogs. Very professional andorganized, crafts done for specialholidays, outside play daily, greattoys and activites.',:postal_code=>'T6M 2R6'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Chitra\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'8731 180 Street',:slug => 'Chitra'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Chitra is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages. Fulltime onlyWill do evenings and weekends.Religious loving home, veryfamily friendly, makes children feel like part of the family. ',:postal_code=>'T5T 0Y1'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Irene\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'18303 93 Ave ',:slug => 'Irene'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Irene is a member of It\'s a Child\'s World Agency', :blurb => 'Open 7:30 - 5:30 Accepts all ages. Great playroom, outside play, circle time, dancing, singing, nature walksm and games.',:postal_code=>'T5T 1V2'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Lourdes\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'9507 180 A St ',:slug => 'Lourdes'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Lourdes is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages. cooks with children, greatactivity planning',:postal_code=>'T5T 2Z4'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Nicole\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'17311 81 Ave ',:slug => 'Nicole'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Nicole is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages. Daily activitesand feildtrips. Children are alwaysout on adventures.',:postal_code=>'T5T 0B8'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Petya\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'7008 187 Street ',:slug => 'Petya'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Petya is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages, prefersfull time. 1 small dog. Will care for behaviour special needs but not physical.',:postal_code=>'T5T 2W2'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Mary Ann\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'37 Gariepy Cresent ',:slug => 'Mary Ann'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Mary Ann is a member of It\'s a Child\'s World Agency', :blurb => 'Prefers full time. Does baking,field trips, dancing and music.',:postal_code=>'T6M 1B5'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Gillian\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'5623 204 Street ',:slug => 'Gillian'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Gillian is a member of It\'s a Child\'s World Agency', :blurb => '1 Cat, goes out in communityand drives children.',:postal_code=>'T6M 0A9'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Sue\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'149 Galland Crescent',:slug => 'Sue'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Sue is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages. Will do evenings, weekends, and extended hours.',:postal_code=>'T5T 6P4'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Fouziah\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'1723 Hammond Dr',:slug => 'Fouziah'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Fouziah is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages and special needs. Enjoys doing baking, cooking, playtime. Has a backyardfor outside play. Will transportwhen weather premits.',:postal_code=>'T6M 0N1'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Fiona\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'5612 205 Street',:slug => 'Fiona'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Fiona is a member of It\'s a Child\'s World Agency', :blurb => 'Will take infants - age 5.1 small dog. Will transport children to school and care forspecial needs. Likes to bake, play music, and do lots of outdoor and indoor physicalactivites.',:postal_code=>'T6M 0B8'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Judith\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'#11, 9350 211 Street',:slug => 'Judith'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Judith is a member of It\'s a Child\'s World Agency', :blurb => 'Will work with babies andtoddlers. Will take children with special needs. Great outdoorplayspace.',:postal_code=>'T5T 4T8'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Hanna\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'851 Chahley Way ',:slug => 'Hanna'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Hanna is a member of It\'s a Child\'s World Agency', :blurb => 'Will take toddlers and preschool.Russian speaking home, great home and great interacton with children.',:postal_code=>'T6M 0C7'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Jane\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'7191 South Terwillegar Dr',:slug => 'Jane'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Jane is a member of It\'s a Child\'s World Agency', :blurb => 'Monday- Thursday Only2 dogs',:postal_code=>'T6R 0P3'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Minal\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'1160 Lincoln Crescent',:slug => 'Minal'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Minal is a member of It\'s a Child\'s World Agency', :blurb => 'Open 7:30- 5pm Accepts all ages. Has a level 3. Very high quality planning and great learning activites.',:postal_code=>'T6R 3B2'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Amina\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'#6 6835 Speaker Vista',:slug => 'Amina'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Amina is a member of It\'s a Child\'s World Agency', :blurb => 'Open until 5pmGreat home and set upwith lots of daily activites.',:postal_code=>'T6R 0S6'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Shahida\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'737 Lauber Crescent',:slug => 'Shahida'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Shahida is a member of It\'s a Child\'s World Agency', :blurb => 'Prefers babies, toddlers, and preschool.Will do evenings andweekends.',:postal_code=>'T6R 3J8'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Roopneet\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'5236 Mullen Crescent',:slug => 'Roopneet'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Roopneet is a member of It\'s a Child\'s World Agency', :blurb => 'Will take children on weekendsAceepts all ages. Has pet birds',:postal_code=>'T6R 0P9'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Nancy\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'10726 32 A Ave ',:slug => 'Nancy'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Nancy is a member of It\'s a Child\'s World Agency', :blurb => 'Speaks spanish with the childrenand helps them learn. Takes childrenout on field trips daily.',:postal_code=>'T6J 2Y9'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Azra\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'3504 Abbot Close ',:slug => 'Azra'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Azra is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages',:postal_code=>'T6W 0X3 '})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Jasdeep\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'6132 6 Avenue SW',:slug => 'Jasdeep'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Jasdeep is a member of It\'s a Child\'s World Agency', :blurb => 'Only availible Thurs- FriAccepts all ages. Always out and about in the commuinty with children.',:postal_code=>'T6X 0G1'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'JeeMee\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'5407 Crabapple Loop SW',:slug => 'JeeMee'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'JeeMee is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages, Level. Great playroom, learning through play program. Excellentinteraction with children. ',:postal_code=>'T6X 1S5'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Monika\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'5125 1B Ave SW',:slug => 'Monika'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Monika is a member of It\'s a Child\'s World Agency', :blurb => 'Current first aid and level 2, and currently going to schoool eveningsand weekends for level 3. Large spacious, clean home in great neighborhood with beautiful backyard.Play area with variety of toys, crafts  and activites to meet childrens intrests and developmental requirements. Nutritious meals and snacks following the Canadian food guide. Pet free and Non Smoking ',:postal_code=>'T6X 0Z7'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Sana\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'',:slug => 'Sana'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Sana is a member of It\'s a Child\'s World Agency', :blurb => 'New home opening soon.',:postal_code=>'T6K 1N3'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Marcy\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'5907 92 Ave ',:slug => 'Marcy'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Marcy is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages.',:postal_code=>'T6B 2G9'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Sarah\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'',:slug => 'Sarah'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Sarah is a member of It\'s a Child\'s World Agency', :blurb => 'Prefers ages 3-12 but accepts allages. Has great outdoor spaceand enjoys playing outside. 2 dogs.baking, fieldtrips, music, yoga, and dance. May care for special needs if it’s the right situation. ',:postal_code=>'T6A 0M7'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Christine\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'',:slug => 'Christine'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Christine is a member of It\'s a Child\'s World Agency', :blurb => 'Will take all ages. Level 3 Special skills include circle time,walks and outside play daily, mathscience, crafts, games, and dancingGreat home with great set up!',:postal_code=>'T7Z 1K1'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Florrette\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'3207 73 Street ',:slug => 'Florrette'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Florrette is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages and specialneeds. Will work Monday to Friday 6:30AM-6:30PM. Great playroom and great variety oftoys. 1 cat Non smoking. ',:postal_code=>'T6K 1K2 '})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Falsome\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'7787 37 Ave ',:slug => 'Falsome'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Falsome is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages. Great home,gentle natured provider with great set up for children. ',:postal_code=>'T6K 1T9'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Lorna\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'4820 15 Avenue ',:slug => 'Lorna'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Lorna is a member of It\'s a Child\'s World Agency', :blurb => 'will take children 0-5 years ',:postal_code=>'T6L 6H9'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Qmar\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'6318 11 Ave ',:slug => 'Qmar'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Qmar is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages Daily outoor activity,  healty meals and snacks,good program. Will care for special needs. ',:postal_code=>'T6L 2G4'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Lisa\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'8108 22 Ave ',:slug => 'Lisa'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Lisa is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages, 2 small dogswill transport children to Satoo School. Will care for special needs ',:postal_code=>'T6K 1Z3'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Pam\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'5518 11 Ave ',:slug => 'Pam'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Pam is a member of It\'s a Child\'s World Agency', :blurb => 'Walks to Sakaw School dailywill care for special needs',:postal_code=>'T6L 2A9'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Yasmin\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'4228 29 Ave ',:slug => 'Yasmin'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Yasmin is a member of It\'s a Child\'s World Agency', :blurb => 'Accepts all ages of children Extended hours and weekends Nurturing Provider, limited outdoortime. Husband drives to schools',:postal_code=>'T6L 4N8'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      d = DayHome.create!({:name => 'Riffat\'s Dayhome',:gmaps =>  true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'3346 21 A Avenue',:slug => 'Riffat'.gsub(' ',''),:email => 'itsachildsworld@shaw.ca', :highlight => 'Riffat is a member of It\'s a Child\'s World Agency', :blurb => 'Great home and set up.Took dayhome provider corse through Norquest College. ',:postal_code=>'T6T 0L2 '})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save

    end
    task :voncreative => :environment do
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
      # create communities
      edmonton = Community.find_by_name("Edmonton")
      edmonton = Community.create!({:name=>"Edmonton"}) unless !edmonton.nil?
      calgary = Community.find_by_name("Calgary")
      calgary =  Community.create!({:name=>"Calgary"}) unless !calgary.nil?
      fortmac = Community.find_by_name("Fort McMurray")
      fortmac =  Community.create!({:name=>"Fort McMurray"}) unless !fortmac.nil?

      # Vonn sample
      org = Organization.create!({:name=>"Von Creative Childcare Network",:postal_code => 'T3G 1L4', :phone_number=>'866-280-6176',:street1 => '159 Ranch Estates Rd NW',:city=>'Calgary',:province=>'Alberta',:plan=>'papa'})
      org.blurb = "[Von Creative](http://www.vonchildcarenetwork.com) is a unique, premium daytime experience offering:\n\n1. Full day curriculum\n1. No unexpected closures\n1. No screen time\n1. First aid / CPR qualified director\n1. Nutritious whole food only menu\n1. Daily outdoor time"
      agencyUser1 =User.find_by_email('peter@voncreative.com')
      if(agencyUser1.nil?)
        agencyUser1 = User.create!({:email => 'peter@voncreative.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'Peter', :last_name => 'Fuerbringer', :admin => false})
      end
      org.users << agencyUser1
      location = Location.create!({:name=>"Calgary"})
      location.community = calgary
      org.locations<<location
      org.save
      logo = OrganizationPhoto.new
      logo.photo = File.open(File.dirname(__FILE__) + "/seeds/dayhomes/vonnetwork.jpg"  )
      org.logo = logo
      pin = OrganizationPhoto.new
      pin.photo = File.open(File.dirname(__FILE__) + "/../../app/assets/images/dayhome-vonn.png"  )
      org.pin = pin
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
          #Splish Splash
          {:postal_code => 'T2L 1S9', :street1 => 'Bulyea Rd NW and Batchelor Crescent NW'},
          {:postal_code => 'T3A 0P4', :street1 => 'Verona Drive NW and Vegas Way NW'},
          {:postal_code => 'T3A 0M8', :street1 => 'Vance Place NW and 39th St NW'},
          {:postal_code => 'T3A 0K4', :street1 => '44th avenue NW and 49th Avenue NW'},
          {:postal_code => 'T3L 2X2', :street1 => 'Tuscany Ravine Crescent NW and Tuscany Ravine Rd NW'},
          {:postal_code => 'T3L 2X4', :street1 => 'Tuscany Ravine Close NW and Tuscany Ravine Rd NW'},

          #Blossom
          {:postal_code => 'T3G 5W2', :street1 => 'Country Hills Blvd and Rocky Ridge Blvd'},
          {:postal_code => 'T3G 5W8', :street1 => 'Country Hills Blvd and Royal Birch Blvd'},
          {:postal_code => 'T3G 5J7', :street1 => 'Rocky Ridge Rd NW and Royal Oak Dr NW'},
          {:postal_code => 'T2E 2S4', :street1 => 'Centre St and 16 Ave'},
          {:postal_code => 'T3G 5J7', :street1 => 'Royal Oak Dr NW and Rocky Ridge Rd NW'},

          #VonKids
          {:postal_code => 'T3L 2Z9', :street1 => 'Tuscany Vista Road NW and Tuscany Vista Crescent NW'},
          {:postal_code => 'T3L 0A7', :street1 => 'Tuscany Reserve Court NW and Tuscany Reserve Rise NW'},
          {:postal_code => 'T3L 2G3', :street1 => 'Tuscarora Place NW and Tuscany Springs Blvd NW'},
          {:postal_code => 'T2W 2V3', :street1 => 'Woodview Place SW and Woodview Crescent SW'},
          {:postal_code => 'T3L 2Z9', :street1 => 'Tuscany Vista Crescent NW and Tuscany Vista Road NW'},
          {:postal_code => 'T2V 0B8', :street1 => '53rd Avenue SW and 4 St SW'},
          {:postal_code => 'T3L 3C9', :street1 => 'Tuscany Drive NW and Tuscany Ridge Heights NW'},
          {:postal_code => 'T3L 2L2', :street1 => 'Tuscany Meadows Heights NW and Tuscany Ravine Road NW'},
          {:postal_code => 'T3L 0A7', :street1 => 'Tuscany Reserve Rise NW and Tuscany Reserve Court NW'},
          {:postal_code => 'T3L 0A4', :street1 => 'Tuscany Reserve Rise NW and Tuscany Reserve Gate NW'},
          {:postal_code => 'T3L 2L2', :street1 => 'Tuscany Meadows Common NW and Tuscany Ravine Road NW'},
          {:postal_code => 'T3L 0A1', :street1 => 'Tuscany Ridge Heights NW and Tuscany way NW'},
          {:postal_code => 'T3K 6J9', :street1 => 'Panamount Heath NW and Panamount Villas NW'},
          {:postal_code => 'T3L 2L5', :street1 => 'Tuscany Springs Place NW and Tuscany Springs Blvd NW'},
          {:postal_code => 'T2T 5C4', :street1 => '21A Street SW and 49 Ave SW'},
          {:postal_code => 'T3C 3B1', :street1 => 'Wedgewood Drive SW and Spruce Drive SW'},
          {:postal_code => 'T3E 0L1', :street1 => '35 ST SW and 25 Ave SW'},
          {:postal_code => 'T3E 0T2', :street1 => '37 ST SW and 30 Ave SW'},
          {:postal_code => 'T3K 6H8', :street1 => 'Panamount Manor NW and Panamount View NW'},

          #Replicon
          {:postal_code => 'T2M 2P7', :street1 => 'Centre Street and 32nd Avenue NW'},
          {:postal_code => 'T2M 0W1', :street1 => '10th Street and 18th Avenue NW'},

          #Neha
          {:postal_code => 'T3L 3C2', :street1 => 'Tuscany Blvd and Tuscany Dr'},

          #Flower Pot Dayhomes
          {:postal_code => 'T3H 0H6', :street1 => 'Aspen Hills Close SW and Aspen Hills Green SW'},
          {:postal_code => 'T3H 0G6', :street1 => 'Aspen Hills Drive SW and Aspen Hills Manor SW'},
          {:postal_code => 'T3H 5G6', :street1 => 'West Springs Close SW and West Springs SW'},

          #Treehouse Academy
          {:postal_code => 'T3B 0T6', :street1 => '44st street NW and 20th Ave NW'},
          {:postal_code => 'T3B 1T2', :street1 => '71st street NW and 35th Ave NW'},
          {:postal_code => 'T3G 3V2', :street1 => 'Citadel Gate NW and Citadel Drive NW'},

          #Safari Dayhomes
          {:postal_code => 'T3G 4W6', :street1 => 'Citadel Vista Close NW and Citadel Way NW'},

          #AuroKids
          {:postal_code => 'T3L 2G3', :street1 => 'Tuscany Springs Blvd NW and Tuscarora Crescent NW'},

          #Regal Childcare
          {:postal_code => 'T3H 0A3', :street1 => 'Cougartown Circle SW and Cougar Plateau Way SW'},
          {:postal_code => 'T3H 5L3', :street1 => 'Cougar Ridge Circle SW and Cougar Ridge Ave SW'},
          {:postal_code => 'T3H 4Z7', :street1 => 'Cougar Ridge Drive SW and Cougarstone Way SW'},
          {:postal_code => 'T3H 5J3', :street1 => 'Cougar Ridge Drive SW and Cougarstone Close SW'},

          #Little Paws Dayhomes
          {:postal_code => 'T3H 4P3', :street1 => 'Wentworth Drive SW and Wentworth Cove SW'},
          {:postal_code => 'T3H 4P2', :street1 => 'Wentworth Circle SW and Wentworth Link SW'},
      ]

      full_time_names = [
          #Splish Splash
          'Jellyfish',
          'Tadpole',
          'Penguin',
          'Turtle',
          'Starfish',
          'Crocodile',

          #Blossom
          'Bluebell',
          'Buttercup',
          'Daffodil',
          'Lily',
          'Poppy',

          #VonKids
          'Achieve',
          'Believe',
          'Blue Bird',
          'Honeybee',
          'Discover',
          'Dragonfly',
          'Dreams',
          'Happitots',
          'Imagine',
          'Inspire',
          'Melody',
          'Stars',
          'Koala',
          'Explore',
          'Ladybug',
          'Grasshoper',
          'Firefly',
          'Caterpillar',
          'Kangaroo',

          #Replicon
          'Von #1',
          'Von #2',

          #Neha
          'Von #3',


          'Tuplip Dayhome',
          'Holly Dayhome',
          'Marigold Dayhome',
          'Acorn Dayhome (Montgomery)',
          'Poplar Dayhome (Bowness)',
          'Bamboo Dayhome (Citadel)',
          'Safari Dayhome (Citadel)', 
          'Creative Dayhome',
          'Willow Dayhome (Cougar Ridge)',
          'Treetops Dayhome (Cougar Ridge)', 
          'Adventure Dayhome (Cougar Ridge)', 
          'Abacus Dayhome (Cougar Ridge)',
          'Little Paws Dayhome (Wentworth)', 
          'Big Paws Dayhome (Wentworth)' 
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
                             :slug => full_time_names[index].gsub(' ',''),
                             :email => "peter@voncreative.com",
                             #:featured => true,
                             #:phone_number => '780-555-5555',
                             :highlight => full_time_names[index]+ " is a member of the Von Premium Childcare Network. All Von Premium Childcare Network programs offer a premium academic and kinesthetic dayhome experience for children.",
                             :blurb => "All Von Premium Childcare Network programs offer:\n\n1. Full day curriculum (toddler-preschool)\n2. No unexpected closures\n3. No screen time policy\n4. Nutritious whole food\n5. Daily outdoor routine\n6. Professional First Aid / CPR qualified director\n7. Pro-active parent communications"
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
    task :samples => :environment do
      # create plans
      baby = Plan.create!({:name=>"Baby Bear",:plan=>"baby",:day_homes=>1, :staff=>0,:locales=>1,:price=>0.00,:block_staff_addon=>1,:block_locales_addon=>1, :active=>Time.now})
      mama= Plan.create!({:name=>"Mama Bear",:plan=>"mama",:day_homes=>50, :staff=>1,:locales=>1,:price=>50.00,:block_staff_addon=>0,:block_locales_addon=>1, :active=>Time.now, :free_features => 1})
      papa=Plan.create!({:name=>"Papa Bear",:plan=>"papa",:day_homes=>250, :staff=>2,:locales=>5,:price=>250.00,:block_staff_addon=>0,:block_locales_addon=>0, :active=>Time.now, :free_features => 5})
      goldilocks=Plan.create!({:name=>"Goldilocks",:plan=>"goldilocks",:day_homes=>-1, :staff=>3,:locales=>-1,:price=>400.00,:block_staff_addon=>0,:block_locales_addon=>0, :active=>Time.now, :free_features => 8})

      # create communities
      edmonton = Community.find_by_name("Edmonton")
      edmonton = Community.create!({:name=>"Edmonton"}) unless !edmonton.nil?
      calgary = Community.find_by_name("Calgary")
      calgary =  Community.create!({:name=>"Calgary"})
      fortmac = Community.find_by_name("Fort McMurray")
      fortmac =  Community.create!({:name=>"Fort McMurray"})

      # create certification types
      level_1 = CertificationType.where({:kind => 'Child Care Level 1'}).first
      level_2 = CertificationType.where({:kind => 'Child Care Level 2'}).first
      level_3 = CertificationType.where({:kind => 'Child Care Level 3'}).first
      basic_cpr = CertificationType.where({:kind => 'Basic First Aid'}).first
      advanced_cpr = CertificationType.where({:kind => 'Advanced First Aid'}).first
      infant_cpr = CertificationType.where({:kind => 'Infant CPR'}).first

      # create availability types
      full_time_full_days = AvailabilityType.where({:availability => 'Full-time', :kind => 'Full Days'}).first
      full_time_after_school = AvailabilityType.where({:availability => 'Full-time', :kind => 'After School'}).first
      full_time_before_school = AvailabilityType.where({:availability => 'Full-time', :kind => 'Before School'}).first
      part_time_full_days = AvailabilityType.where({:availability => 'Part-time', :kind => 'Full Days'}).first
      part_time_morning = AvailabilityType.where({:availability => 'Part-time', :kind => 'Morning'}).first
      part_time_afternoon = AvailabilityType.where({:availability => 'Part-time', :kind => 'Afternoon'}).first
      part_time_after_school = AvailabilityType.where({:availability => 'Part-time', :kind => 'After School'}).first
      part_time_before_school = AvailabilityType.where({:availability => 'Part-time', :kind => 'Before School'}).first

      review_1 = Review.new({:content => 'Bacon ipsum dolor sit amet tri-tip pancetta cow kielbasa. Shank jerky meatloaf, kielbasa sirloin chuck jowl frankfurter swine boudin shoulder pastrami. Bresaola ham kielbasa, meatloaf tri-tip jowl tongue filet mignon flank ball tip brisket andouille. Filet mignon boudin t-bone swine turkey ball tip.', :rating => 2})
      review_2 = Review.new({:content => 'Meatloaf short loin shankle tri-tip. Tri-tip swine turducken pork, filet mignon flank ribeye ball tip jowl. Tongue hamburger short ribs, jowl spare ribs filet mignon chuck t-bone. Sirloin ham boudin, pancetta pork loin drumstick ground round shank capicola chuck corned beef strip steak swine venison.', :rating => 1})
      review_3 = Review.new({:content => 'Salami pork capicola prosciutto tri-tip biltong, shank chuck pig corned beef pancetta fatback jowl. Swine shank speck pancetta, salami jowl spare ribs cow tri-tip shankle ground round. Spare ribs meatball pork, jerky strip steak short loin speck bresaola kielbasa beef pork loin. Bacon turducken chicken ham pancetta pork belly, beef ribs shank capicola sirloin boudin short loin frankfurter shoulder.', :rating => 5})
      review_4 = Review.new({:content => 'Meatball turducken filet mignon shankle, frankfurter pig short loin brisket rump pork chop. Chicken bacon salami filet mignon corned beef bresaola, ball tip beef ribs meatball. Bacon pork belly sausage, salami t-bone tri-tip shoulder strip steak ham speck jerky chuck pork brisket turducken.', :rating => 5})
      review_5 = Review.new({:content => 'Turkey tail ham hock venison, pancetta chicken jerky tri-tip rump ball tip beef ribs frankfurter jowl. Shank bresaola sausage, pork chop chicken chuck pancetta ham hock salami turkey brisket.', :rating => 3})
      review_6 = Review.new({:content => 'Speck spare ribs shoulder ground round prosciutto, bresaola venison turducken pork belly swine short loin. Jowl ball tip ground round, jerky pork belly venison prosciutto pancetta ham drumstick corned beef strip steak pork hamburger ham hock.', :rating => 0})
      review_7 = Review.new({:content => 'Pancetta speck ribeye, ham hock pork loin spare ribs brisket ball tip.', :rating => 1})

      reviews = [review_1, review_2, review_3, review_4, review_5, review_6, review_7]

      # Create Default Admin User
      admin_user = User.create!({:email => 'dayadmin@dayhomeregistry.com', :password => 'day4admin', :password_confirmation => 'day4admin', :first_name => 'DayHome', :last_name => 'Admin', :admin => true})
      user0 = User.create!({:email => 'test0@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'Marty', :last_name => 'Bristow', :admin => false})
      user1 = User.create!({:email => 'test1@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'Lestor', :last_name => 'Hart', :admin => false})
      user2 = User.create!({:email => 'test2@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'Betty', :last_name => 'Williams', :admin => false})
      user3 = User.create!({:email => 'test3@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'May', :last_name => 'Manweiler', :admin => false})
      user4 = User.create!({:email => 'test4@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'Marilyn', :last_name => 'Dennis', :admin => false})
      user5 = User.create!({:email => 'test5@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'Lisa', :last_name => 'Schreder', :admin => false})
      user6 = User.create!({:email => 'test6@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'Faye', :last_name => 'Morrison', :admin => false})

      users = [ user0, user1, user2, user3, user4, user5, user6]

      # Create basic agency
      org = Organization.create!({:name=>"Child Development Dayhomes",:postal_code => 'T5N1Y6', :street1 => '131 St NW',:city=>'Edmonton',:province=>'Alberta',:plan=>'papa'})
      agencyUser1 = User.create!({:email => 'agency1@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'Bobby', :last_name => 'Arya', :admin => false})
      agencyUser2 = User.create!({:email => 'agency2@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'Brenda', :last_name => 'Schuler', :admin => false})
      org.users << agencyUser1
      org.users << agencyUser2
      location = Location.create!({:name=>"Edmonton"})
      location.community = edmonton
      org.locations<<location
      org.save

      # address hashes
      fulltime_addresses = [
          {:postal_code => 'T5N1Y6', :street1 => '131 St NW'},
          {:postal_code => 'T5S1R5', :street1 => '178 St NW'},
          {:postal_code => 'T6C0P9', :street1 => '79 Avenue Northwest'},
          {:postal_code => 'T5E4E5', :street1 => '128 Avenue Northwest'},
          {:postal_code => 'T6E3J5'},
          {:postal_code => 'T6A7R6'},
          {:postal_code => 'T6F0F5'},
          {:postal_code => 'T5J2F6'},
          {:postal_code => 'T5W7H5'},
          {:postal_code => 'T6I2K6'},
          {:postal_code => 'T6X6Z5'},
          {:postal_code => 'T6Z1G5'},
          {:postal_code => 'T6P9D6'},
          {:postal_code => 'T6G0I5'},
          {:postal_code => 'T5X8W6'},
          {:postal_code => 'T5G4A5'},
          {:postal_code => 'T6P8X5'},
          {:postal_code => 'T5X5I6'},
          {:postal_code => 'T5D2J5'},
          {:postal_code => 'T5I3D5'},
          {:postal_code => 'T6V1C5'},
          {:postal_code => 'T5X3S6'},
          {:postal_code => 'T6Y9Y6'},
          {:postal_code => 'T5J7X5'},
          {:postal_code => 'T6H0O6'},
          {:postal_code => 'T5D1U6'},
          {:postal_code => 'T5Y0Z5'},
          {:postal_code => 'T5N2J5'},
          {:postal_code => 'T6X5W5'},
          {:postal_code => 'T5L0Z6'},
          {:postal_code => 'T6Z2J5'},
          {:postal_code => 'T6F3H6'},
          {:postal_code => 'T6H1H6'},
          {:postal_code => 'T6D5K5'},
          {:postal_code => 'T6W3C5'},
          {:postal_code => 'T6O1B6'},
          {:postal_code => 'T6C2I5'},
          {:postal_code => 'T5P9M5'},
          {:postal_code => 'T6C8U5'},
          {:postal_code => 'T6E8W5'},
          {:postal_code => 'T5D4Q6'},
          {:postal_code => 'T5Z4J5'},
          {:postal_code => 'T5B0O6'},
          {:postal_code => 'T5N4W6'},
          {:postal_code => 'T6B1D6'},
          {:postal_code => 'T6Y1W5'},
          {:postal_code => 'T6H4I6'},
          {:postal_code => 'T6L8S6'},
          {:postal_code => 'T6Y0Z5'},
          {:postal_code => 'T5K0R6'},
          {:postal_code => 'T6P1A5'},
          {:postal_code => 'T6Z9N5'},
          {:postal_code => 'T6B9E6'},
          {:postal_code => 'T6P9Q6'},
          {:postal_code => 'T6Y3J6'},
          {:postal_code => 'T6F2Q6'},
          {:postal_code => 'T6E0I5'},
          {:postal_code => 'T6N6A5'}
      ]
      calgary_addresses = [
          {:postal_code => 'T3A 5P2', :street1 => '107 Hampstead Cir NW'},
          {:postal_code => 'T2P 1J5', :street1 => '1100 8 Ave SW'},
          {:postal_code => 'T2A 4H8', :street1 => '1115 Marcombe Cres NE'},
          {:postal_code => 'T3J 1Y8', :street1 => '116 Castleridge Dr NE'},
          {:postal_code => 'T3K 3Z2', :street1 => '116 Country Hills Close NW'},
          {:postal_code => 'T3K 5L8', :street1 => '118 Panamount Cres NW'},
          {:postal_code => 'T3G 4X5', :street1 => '12 Royal Terr NW'},
          {:postal_code => 'T3K 2E9', :street1 => '120 Bernard Way NW'},
          {:postal_code => 'T2G 5G4', :street1 => '122 3 Ave SE'},
          {:postal_code => 'T2E 1B6', :street1 => '130 13 Ave NE'},
          {:postal_code => 'T3G 1N2', :street1 => '1455 Ranchlands Rd NW'},
          {:postal_code => 'T3G 2Z9', :street1 => '152 Hawkdale Close NW'},
          {:postal_code => 'T3G 1L4', :street1 => '159 Ranch Estates Rd NW'},
          {:postal_code => 'T2E 8S7', :street1 => '1623 Centre St NW'},
          {:postal_code => 'T3H 3V1', :street1 => '18 Spring Cres SW'},
          {:postal_code => 'T3H 5M8', :street1 => '183 Springborough Way SW'},
          {:postal_code => 'T3K 2A9', :street1 => '196 Bermuda Dr NW'},
          {:postal_code => 'T3H 1E6', :street1 => '20 Coachway Rd SW'},
          {:postal_code => 'T2P 1M3', :street1 => '200 1 St SW'},
          {:postal_code => 'T2B 0W9', :street1 => '2012 35 St SE'},
          {:postal_code => 'T2E 2C2', :street1 => '221 29 Ave NE'},
          {:postal_code => 'T2E 4E7', :street1 => '223 7a St NE'},
          {:postal_code => 'T3A 5N3', :street1 => '246 Hidden Spring Mews NW'},
          {:postal_code => 'T3A 5Y6', :street1 => '250 Hampstead Gdns NW'},
          {:postal_code => 'T3H 2V1', :street1 => '2876 Signal Hill Dr SW'},
          {:postal_code => 'T2W 3V9', :street1 => '296 Woodfield Rd SW'},
          {:postal_code => 'T2Z 4E8', :street1 => '314 McKenzie Towne Link SE'},
          {:postal_code => 'T3A 2C6', :street1 => '3302 50 St NW'},
          {:postal_code => 'T1Y 6V5', :street1 => '36 Del Ray Rd NE'},
          {:postal_code => 'T2Z 3C3', :street1 => '3757 Douglas Ridge Way SE'},
          {:postal_code => 'T3K 0C6', :street1 => '38 Panamount Row NW'},
          {:postal_code => 'T2L 1G8', :street1 => '3812 Brighton Dr NW'},
          {:postal_code => 'T2K 0X8', :street1 => '4305 1a St NW'},
          {:postal_code => 'T3K 5N5', :street1 => '44 Panorama Hills Heath NW'},
          {:postal_code => 'T3A 6N6', :street1 => '4729 Hamptons Way NW'},
          {:postal_code => 'T2E 0X6', :street1 => '540 10 Ave NE'},
          {:postal_code => 'T3A 1E6', :street1 => '5812 Dalmead Cres NW'},
          {:postal_code => 'T1Y 2C3', :street1 => '5822 Rundlehorn Dr NE'},
          {:postal_code => 'T3H 2R3', :street1 => '7020 Christie Briar Manor SW'},
          {:postal_code => 'T2K 5B6', :street1 => '7379 Huntington St NE'},
          {:postal_code => 'T3K 4Y6', :street1 => '74 Country Hills Hts NW'},
          {:postal_code => 'T2K 4P8', :street1 => '7827 Hunterview Dr NW'},
          {:postal_code => 'T3H 5S1', :street1 => '7981 Cougar Ridge Ave SW'},
          {:postal_code => 'T1Y 6R2', :street1 => '8 Del Monica Bay NE'},
          {:postal_code => 'T2S 0S1', :street1 => '803 Rideau Rd SW'},
          {:postal_code => 'T3K 5R4', :street1 => '84 Covepark Close NE'}
      ]

      part_time_addresses = [
          {:postal_code => 'T6W1C3', :street1 => '793 blackburn place'},
          {:postal_code => 'T6L5M6', :street1 => '4138 36st NW'}
      ]

      no_availability_addresses = [
          {:postal_code => 'T6J5M5', :street1 => '2978 106 Street NW'},
          {:postal_code => 'T5S1S5', :street1 => '10070 178 Street NW'}
      ]
      dummy_text = [
          "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean.",
          "A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth.",
          "Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar.",
          "The Big Oxmox advised her not to do so, because there were thousands of bad Commas, wild Question Marks and devious Semikoli, but the Little Blind Text didn't listen. She packed her seven versalia, put her initial into the belt and made herself on the way.",
          "When she reached the first hills of the Italic Mountains, she had a last view back on the skyline of her hometown Bookmarksgrove, the headline of Alphabet Village and the subline of her own road, the Line Lane."
      ]
      fulltime_names = [
          "Fanny fulltime",
          "Two bears fulltime",
          "Mayday fulltime",
          "Alternative fulltime",
          "Aardvark Dayhome",
          "Abase Dayhome",
          "Abate Dayhome",
          "Abbot Dayhome",
          "Abel Dayhome",
          "Abhorred Dayhome",
          "Abject Dayhome",
          "Ablest Dayhome",
          "Aboard Dayhome",
          "Aborts Dayhome",
          "Above Dayhome",
          "Abroad Dayhome",
          "Abscessed Dayhome",
          "Absent Dayhome",
          "Absolves Dayhome",
          "Abstain Dayhome",
          "Abuse Dayhome",
          "Accents Dayhome",
          "Acclaim Dayhome",
          "Accosts Dayhome",
          "Accrue Dayhome",
          "Accursed Dayhome",
          "Aces Dayhome",
          "Aching Dayhome",
          "Acing Dayhome",
          "Acorn Dayhome",
          "Aardvarks Dayhome",
          "Abased Dayhome",
          "Abates Dayhome",
          "Abbots Dayhome",
          "Abet Dayhome",
          "Abhors Dayhome",
          "Ablaze Dayhome",
          "Abloom Dayhome",
          "Abode Dayhome",
          "Abound Dayhome",
          "Abreast Dayhome",
          "Abrupt Dayhome",
          "Abscond Dayhome",
          "Absents Dayhome",
          "Absorb Dayhome",
          "Abstract Dayhome",
          "Abused Dayhome",
          "Accept Dayhome",
          "Accord Dayhome",
          "Account Dayhome",
          "Accrued Dayhome",
          "Accurst Dayhome",
          "Achieve Dayhome",
          "Achy Dayhome",
          "Acme Dayhome",
          "Acorns Dayhome",
          "Aaron Dayhome",
          "Abash Dayhome"
      ]
      calgary_names = [
          "Abbey Dayhome",
          "Abduct Dayhome",
          "Abets Dayhome",
          "Abide Dayhome",
          "Able Dayhome",
          "Ably Dayhome",
          "Abodes Dayhome",
          "Abounds Dayhome",
          "Abridge Dayhome",
          "Abscam Dayhome",
          "Absconds Dayhome",
          "Absolve Dayhome",
          "Absorbed Dayhome",
          "Abstracts Dayhome",
          "Accede Dayhome",
          "Accepts Dayhome",
          "Accords Dayhome",
          "Accountants Dayhome",
          "Accrues Dayhome",
          "Accuse Dayhome",
          "Achieved Dayhome",
          "Acid Dayhome",
          "Acne Dayhome",
          "Aback Dayhome",
          "Abashed Dayhome",
          "Abbeys Dayhome",
          "Abducts Dayhome",
          "Abhor Dayhome",
          "Abides Dayhome",
          "Abler Dayhome",
          "Abner Dayhome",
          "Abort Dayhome",
          "About Dayhome",
          "Abridged Dayhome",
          "Abscess Dayhome",
          "Absence Dayhome",
          "Absolved Dayhome",
          "Absorbs Dayhome",
          "Absurd Dayhome",
          "Accent Dayhome",
          "Access Dayhome",
          "Accost Dayhome",
          "Accounts Dayhome",
          "Accurse Dayhome",
          "Accused Dayhome",
          "Achieves Dayhome"
      ]
      part_time_names = [
          "Patty part-time",
          "Chocolate part-time",
          "Mint part-time",
          "Butterscotch part-time"
      ]
      no_availability_names = [
          "Awesome All-full",
          "Penelope Plein"
      ]

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

      # Create a dayhome with reviews
      o1 = Organization.create!({:name=>"DayHome With Reviews",:postal_code => 'T6L5M6', :phone_number => '780-555-5555',:street1 => '4138 36st NW',:city=>'Edmonton',:province=>'Alberta'})
      l1 = Location.create!({:name=>"Edmonton"})
      l1.community = edmonton
      agencyUser2.location = l1
      o1.locations << l1
      day_home_with_reviews = DayHome.create!({:name => "DayHome With Reviews",
                                               :gmaps =>  true,
                                               :city =>  'Edmonton',
                                               :province =>  'AB',
                                               :street1 => '4138 36st NW',
                                               :street2 =>  '',
                                               :slug => 'DayHomesWithReviews',
                                               :email => 'withreviews123@dayhomeregistry.com',
                                               :postal_code => 'T6L5M6',
                                               :highlight => 'Dayhome With Reviews is a terrific place for children to learn and have fun. With all sorts of activities in store, kids love it.',
                                               :blurb => 'Dayhome With Reviews is a terrific place for children to learn and have fun. With all sorts of activities in store, kids love it.'                                               
                                              })
      day_home_with_reviews.availability_types << full_time_full_days
      l1.day_homes << day_home_with_reviews
      o1.save
      l1.save
      photos = [
          { :caption => "Six and counting.", :photo => "counting.jpg"},
          { :caption => "We provide arts and crafts.", :photo => "crayons.jpg"},
          { :caption => "There are activities for all children.", :photo => "playdoe.jpg"},
          { :caption => "Outdoor playground", :photo => "swing.jpg" }
      ]
      add_photos_to_dayhome(photos, day_home_with_reviews)
      #feature this dayhome
      f1= Feature.create!({:start=>DateTime.now(),:end=>DateTime.now()+1.month, :day_home_id=>day_home_with_reviews.id,:organization_id=>o1.id,:freebee=>false})

      # add reviews to day_home_with_reviews
      reviews.each_with_index do |rev, index|
        rev.user = users[index]
        rev.day_home = day_home_with_reviews
        rev.save!
      end


      # Create a couple of dayhomes with full time
      photos = [
          { :caption => "Tasty snacks.", :photo => "cereal.jpg"},
          { :caption => "We provide arts and crafts.", :photo => "crafts.jpg"},
          { :caption => "Activities for all ages.", :photo => "finger_painting.jpg"},
          { :caption => "Healthy food alternatives.", :photo => "fruit_salad.jpg" }
      ]
      fulltime_addresses.each_with_index  do |street_and_postal, index|
        
        d = DayHome.create!({:name => fulltime_names[index],
                             :gmaps =>  true,
                             :city =>  'Edmonton',
                             :province =>  'AB',
                             :street2 =>  '',
                             :slug => "DayHome#{index}single",
                             :email => "dh564f#{index}@dayhomeregistry.com",
                             #:featured => true,
                             :phone_number => '780-555-5555',
                             :highlight => fulltime_names[index]+" is a terrific place for children to learn and have fun. With all sorts of activities in store, kids love it.",
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
      calgary_addresses.each_with_index  do |street_and_postal, index|
        
        d = DayHome.create!({:name => calgary_names[index],
                             :gmaps =>  true,
                             :city =>  'Calgary',
                             :province =>  'AB',
                             :street2 =>  '',
                             :slug => "DayHomeCAL#{index}single",
                             :email => "dhCALf#{index}@dayhomeregistry.com",
                             #:featured => true,
                             :phone_number => '780-555-5555',
                             :highlight => calgary_names[index]+" is a terrific place for children to learn and have fun. With all sorts of activities in store, kids love it.",
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

      # Create a couple of dayhomes with part time
      photos = [
          { :caption => "Fun all day long", :photo => "laughing_outside.jpg" },
          { :caption => "Group activities", :photo => "playing_kids.jpg" },
          { :caption => "Homemade lunches", :photo => "mac_and_cheese.jpg" },
          { :caption => "Stimulating activities.", :photo => "lego.jpg" },
      ]
      part_time_addresses.each_with_index  do |street_and_postal, index|
        o = Organization.create!({:name=>part_time_names[index]}.merge(street_and_postal))
        l = Location.create!({:name=>"Edmonton"})
        o.locations << l
        d = DayHome.create!({:name => part_time_names[index],
                             :gmaps =>  true,
                             :city =>  'Edmonton',
                             :province =>  'AB',
                             :street2 =>  '',
                             :slug => "DayHome#{index}partime",
                             :email => "dh32p#{index}@dayhomeregistry.com",
                             :phone_number => '17809062943',
                             #:featured => true,
                             :highlight => part_time_names[index]+" is a terrific place for children to learn and have fun. With all sorts of activities in store, kids love it.",
                             :blurb => dummy_text[1+Random.rand(4)]+"\n"+dummy_text[1+Random.rand(4)]+"\n"+dummy_text[1+Random.rand(4)]+"\n"                             
                            }.merge(street_and_postal))
        d.availability_types << part_time_morning
        d.certification_types << basic_cpr
        if index.odd?
          d.licensed = true
          d.availability_types << part_time_afternoon
        end
        add_photos_to_dayhome(photos, d)
        l.day_homes << d
        o.save
        l.save
        d.save
      end

      # Create a couple of dayhomes with no availability
      no_availability_addresses.each_with_index  do |street_and_postal, index|
        o = Organization.create!({:name=>no_availability_names[index]}.merge(street_and_postal))
        l = Location.create!({:name=>"Edmonton"})
        o.locations << l
        d = DayHome.create!({:name => no_availability_names[index],
                             :gmaps =>  true,
                             :city =>  'Edmonton',
                             :province =>  'AB',
                             :street2 =>  '',
                             :slug => "DayHome#{index}noavail",
                             :phone_number => '17809062942',
                             :email => "dhn#{index}@dayhomeregistry.com",
                             :highlight => no_availability_names[index]+" is a terrific place for children to learn and have fun. With all sorts of activities in store, kids love it.",
                             :blurb => dummy_text[1+Random.rand(4)]+"\n"+dummy_text[1+Random.rand(4)]+"\n"+dummy_text[1+Random.rand(4)]+"\n"                                                          
                            }.merge(street_and_postal))
        d.availability_types << part_time_before_school
        d.availability_types << full_time_after_school
        d.certification_types << advanced_cpr
        if index.odd?
          d.availability_types << part_time_full_days
          d.dietary_accommodations = true
          d.save!
        end
        l.day_homes << d
        o.save
        l.save
        d.save        
      end

      # create a user related to a dayhome
      first_day_home = DayHome.first
      user_related_to_dayhome = User.create!({:email => 'dayhomeadmin@dayhomes.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'dayhome', :last_name => 'admin', :admin => false})
      user_related_to_dayhome.day_homes << first_day_home

      # create events for the above dayhome
      Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now - 3, :ends_at => DateTime.now - 2, :all_day => false, :day_home_id => first_day_home.id })
      Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now - 3, :ends_at => DateTime.now - 2 + 3.hours, :all_day => false, :day_home_id => first_day_home.id })
      Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now, :ends_at => DateTime.now + 3, :all_day => false, :day_home_id => first_day_home.id })
      Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now, :ends_at => DateTime.now + 1, :all_day => false, :day_home_id => first_day_home.id })
      Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now + 3.hours, :ends_at => DateTime.now + 5.hours, :all_day => false, :day_home_id => first_day_home.id })
      Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now + 6.hours, :ends_at => DateTime.now + 8.hours, :all_day => false, :day_home_id => first_day_home.id })
      Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now + 5, :ends_at => DateTime.now + 8, :all_day => false, :day_home_id => first_day_home.id })
      Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now + 10, :ends_at => DateTime.now + 11, :all_day => false, :day_home_id => first_day_home.id })
      Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now + 10 + 3.hours, :ends_at => DateTime.now + 12, :all_day => false, :day_home_id => first_day_home.id })
      Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now + 10 + 7.hours, :ends_at => DateTime.now + 12, :all_day => false, :day_home_id => first_day_home.id })
      Event.create!({:title => 'Test', :description => 'Test', :starts_at => DateTime.now, :ends_at => DateTime.now + 20, :all_day => false, :day_home_id => first_day_home.id })

      # forum seed data
      #create the categories
      cat_day = Category.create!({:title => 'Dayhomes', :position => 0})
      cat_nut = Category.create!({:title => 'Nutrition', :position => 0})
      cat_act = Category.create!({:title => 'Activities', :position => 0})

      #create the forums under each category
      main_forum = Forum.create!({:category_id => cat_day.id, :title => 'General Discussion', :position => 0, :description => 'Chat about your dayhome!'})
      nutrition_age_0 = Forum.create!({:category_id => cat_nut.id, :title => 'Age 0 - 1', :position => 0, :description => 'Discuss meals & snacks for ages 0 - 1'})
      Forum.create!({:category_id => cat_nut.id, :title => 'Age 1 - 2', :position => 0, :description => 'Discuss meals & snacks for ages 1 - 0'})
      Forum.create!({:category_id => cat_act.id, :title => 'Morning', :position => 0, :description => 'What activities do you do during the morning?'})
      Forum.create!({:category_id => cat_act.id, :title => 'Recess', :position => 0, :description => 'What activities do you do during recess?'})
      Forum.create!({:category_id => cat_act.id, :title => 'Afternoon', :position => 0, :description => 'What activities do you do during the afternoon?'})

      # create some forum topics
      t0 = Topic.new({:title => '(Sticky) Items that should be banned?', :sticky => true,  :locked => false, :body => 'Does anyone have a list of banned items for parents?'})
      t0.forum = main_forum
      t0.user = user_related_to_dayhome
      t0.save!

      t1 = Topic.new({:title => 'Where do you put your shoes?', :sticky => false,  :locked => false, :body => 'On a rack??'})
      t1.forum = main_forum
      t1.user = user_related_to_dayhome
      t1.save!

      t2 = Topic.new({:title => 'Allergic reaction scare!', :sticky => false,  :locked => false, :body => "Don't buy special brand bars! Have nuts!!!"})
      t2.forum = nutrition_age_0
      t2.user = user_related_to_dayhome
      t2.save!

      # create some responses to the above topics
      p1 = Post.new({:body => "Here's a list of banned items we have: knives, sharp pens, gameboys."})
      p1.forum = main_forum
      p1.user = user_related_to_dayhome
      p1.topic = t0
      p1.save!

      # create some responses to the above topics
      p1 = Post.new({:body => "We've had to ban lead covered toys and pens."})
      p1.forum = main_forum
      p1.user = user_related_to_dayhome
      p1.topic = t0
      p1.save!

      # create some responses to the above topics
      p1 = Post.new({:body => "We store them in a closet and have a child have an ID."})
      p1.forum = main_forum
      p1.user = user_related_to_dayhome
      p1.topic = t1
      p1.save!
      puts "Dev/Test Seed Complete"
    end
  end
end