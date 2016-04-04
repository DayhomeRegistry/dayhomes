#encoding: utf-8 
namespace :db do
  

  namespace :seed do
    task :medallion => :environment do
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
          { :caption => "Southgate Medallion", :photo => "southgatemedallion.png"}
      ]
      # get certification types
      level_1 = CertificationType.where({:kind => 'Child Care Level 1'}).first
      level_2 = CertificationType.where({:kind => 'Child Care Level 2'}).first
      level_3 = CertificationType.where({:kind => 'Child Care Level 3'}).first
      crc = CertificationType.where({:kind => 'Criminal Record Check'}).first
      cwc = CertificationType.where({:kind => 'Child Welfare Check'}).first
      bfa = CertificationType.where({:kind => 'Basic First Aid'}).first
      afa = CertificationType.where({:kind => 'Advanced First Aid'}).first
      icpr = CertificationType.where({:kind => 'Infant CPR'}).first

      # get availability types
      fully = AvailabilityType.all

      org = Organization.find_by_id(526)
      location = Location.find_by_id(544)

      #Dayhomes
      d=DayHome.create!({:name => 'Samarhan\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'54 AVE and 143 ST',:slug => 'Samarhans day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Brookside/Riverbend!', :blurb => 'Samarhan\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6H 4E4'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Bisola\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'60 ST and 13 AVE',:slug => 'Bisolas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Walker/Ellerslie!', :blurb => 'Bisola\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6X 0M7'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Alina\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'8 AVE and 112A ST',:slug => 'Alinas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Twin Brooks!', :blurb => 'Alina\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6J 6W3'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Madhu\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Todd Link',:slug => 'Madhus day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Terwillegar Towne!', :blurb => 'Madhu\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6R 3C5'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Shabana\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Whitelaw Drive',:slug => 'Shabanas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Windermere!', :blurb => 'Shabana\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 0P6'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Nazia\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Mann Lane',:slug => 'Nazias day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in MacTaggart!', :blurb => 'Nazia\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6R 0P6'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Hajera\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'67 ST and 12 AVE',:slug => 'Hajeras day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Summerside!', :blurb => 'Hajera\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6X 1L2'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Miriam\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Getty Wynd',:slug => 'Miriams day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Granville!', :blurb => 'Miriam\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T5T 6W4'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Nassreen\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'23 ST and 33A AVE',:slug => 'Nassreens day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Silver Berry!', :blurb => 'Nassreen\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6T 1Z3'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Adeeba\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'53 ST and 164 AVE',:slug => 'Adeebas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Hollick-Kenyon!', :blurb => 'Adeeba\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T5Y 0H4'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_2
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Maribel\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'186 ST and 74 AVE',:slug => 'Maribels day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Lymburn/Callingwood!', :blurb => 'Maribel\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T5T 5J9'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Parwinder\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'169 AVE and 103 ST',:slug => 'Parwinders day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Baturyn!', :blurb => 'Parwinder\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T5X 4Z4'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Eugene\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'5 AVE and 119 ST SW',:slug => 'Eugenes day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in MacEwan!', :blurb => 'Eugene\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 1R4'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Mari\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'108 ST and 52 AVE',:slug => 'Maris day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Pleasantview!', :blurb => 'Mari\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6H 0P2'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Lana\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'33 ST and 25 AVE',:slug => 'Lanas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Silver Berry!', :blurb => 'Lana\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6T 1Y3'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_2
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Tonia\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'45 ST and 33A AVE',:slug => 'Tonias day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Weinlos!', :blurb => 'Tonia\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6L 4X7'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Paulette\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'158 ST and 10 AVE SW',:slug => 'Paulettes day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Glenridding Heights!', :blurb => 'Paulette\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 2H2'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_2
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Allyn\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'54 ST and 5 AVE SW',:slug => 'Allyns day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Charlesworth!', :blurb => 'Allyn\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6X 1R9'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Dharmishtha\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'33 ST and 17B AVE',:slug => 'Dharmishthas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Laurel!', :blurb => 'Dharmishtha\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6T 0K3'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Parul\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'8 ST and 6 AVE SW',:slug => 'Paruls day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Ellerslie!', :blurb => 'Parul\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6X 1G4'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Naeema\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Lacombe Court',:slug => 'Naeemas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Leger!', :blurb => 'Naeema\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6R 3T4'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Dhruti\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'19 AVE and 67 ST SW',:slug => 'Dhrutis day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Summerside!', :blurb => 'Dhruti\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6X 0L9'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Tami\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'162 AVE and 132 ST',:slug => 'Tamis day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Oxford!', :blurb => 'Tami\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6V 1X6'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Jenifa\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'24 AVE and 107 ST',:slug => 'Jenifas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Ermineskin!', :blurb => 'Jenifa\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6J 5N4'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Karamdeep\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'29 ST and 152 AVE',:slug => 'Karamdeeps day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Kirkness!', :blurb => 'Karamdeep\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T5Y 2Y4'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Khushbir\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'60 ST and 162B AVE',:slug => 'Khushbirs day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Matt Berry!', :blurb => 'Khushbir\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T5Y 2R3'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_2
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Tiffany\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Adamson Terrace',:slug => 'Tiffanys day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Allard!', :blurb => 'Tiffany\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 2N7'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Janice\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'55 ST and 14A AVE',:slug => 'Janices day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Sakaw!', :blurb => 'Janice\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6L 3B6'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Dee\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Sherwood Park',:province =>  'AB',:street2 =>  '',:street1=>'Great Oaks',:slug => 'Dees day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Broadmoor Estates!', :blurb => 'Dee\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T8A 0X2'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Marie Rose\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Chapman Way',:slug => 'Marie Roses day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Chappelle!', :blurb => 'Marie Rose\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 1A7'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Liza\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Adams Way',:slug => 'Lizas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Ambleside!', :blurb => 'Liza\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 0K2'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Iman\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'184 ST and 80 AVE',:slug => 'Imans day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Aldergrove!', :blurb => 'Iman\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T5T 1E8'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Bidula\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'116 ST and 11A AVE',:slug => 'Bidulas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Twin Brooks!', :blurb => 'Bidula\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6J 6Y7'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Vera\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'207 ST and 61 AVE',:slug => 'Veras day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in The Hamptons!', :blurb => 'Vera\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6M 0K8'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Amra\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'115 ST and 41 AVE',:slug => 'Amras day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Royal Gardens!', :blurb => 'Amra\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6J 0V1'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Farzana\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'30 ST and 30 AVE',:slug => 'Farzanas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Silver Berry!', :blurb => 'Farzana\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6T 1V2'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Angela\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'6 AVE and 171 ST SW',:slug => 'Angelas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Windermere!', :blurb => 'Angela\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 1A5'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Jennifer\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'171 ST and 5 AVE SW',:slug => 'Jennifers day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Windermere!', :blurb => 'Jennifer\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 2A4'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Nargis\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Kiniski Crescent',:slug => 'Nargiss day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Kiniski Gardens/Burnewood!', :blurb => 'Nargis\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6L 5E2'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Nafisa\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Grand Meadown Crescent',:slug => 'Nafisas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Greenview/Woodvale!', :blurb => 'Nafisa\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6L 1A2'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Kaimin\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'116 ST and 16A AVE SW',:slug => 'Kaimins day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Rutherford!', :blurb => 'Kaimin\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 0N3'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Yunpok\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'48 AVE and 122A ST',:slug => 'Yunpoks day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Malmo/Landsdowne!', :blurb => 'Yunpok\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6H 5B5'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Dinesha\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'202 Southridge',:slug => 'Dineshas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Empire Park!', :blurb => 'Dinesha\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6H 4M9'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Shoeleh\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'19 AVE and 120 ST SW',:slug => 'Shoelehs day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Rutherford!', :blurb => 'Shoeleh\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 0A8'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Meeka\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'22 AVE and 113 ST',:slug => 'Meekas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Skyrattler!', :blurb => 'Meeka\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6J 5K9'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Amarjeet\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'18 AVE and 33 ST',:slug => 'Amarjeets day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Laurel!', :blurb => 'Amarjeet\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6T 0L5'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Humera\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'15 AVE and 60 ST SW',:slug => 'Humeras day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Walker!', :blurb => 'Humera\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6X 0V8'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Koreen\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'21 AVE and 78 ST NW',:slug => 'Koreens day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Satoo/Knotwood!', :blurb => 'Koreen\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6K 2E5'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Marie\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'117 ST and 28 AVE',:slug => 'Maries day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Blue Quill!', :blurb => 'Marie\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6J 3P2'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Rupinder\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Tamarack Road',:slug => 'Rupinders day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Tamarack!', :blurb => 'Rupinder\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6T 0M8'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Linda\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'87 ST and 66 AVE',:slug => 'Lindas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Argyll!', :blurb => 'Linda\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6E 0L3'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Malgorzata\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'88 AVE and 91 ST',:slug => 'Malgorzatas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Bonnie Doon!', :blurb => 'Malgorzata\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6C 4L4'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Heather\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Marion Place',:slug => 'Heathers day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in MacEwan!', :blurb => 'Heather\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 1P9'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Ching\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'174 AVE and 90 ST',:slug => 'Chings day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Klarvatten/Lake District!', :blurb => 'Ching\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T5Z 3X8'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_2
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Joanne\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'52 ST and 19 AVE',:slug => 'Joannes day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Meyokumin/Millhurst!', :blurb => 'Joanne\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6L 1J7'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Generosa\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'20 AVE and 70 ST SW',:slug => 'Generosas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Summerside!', :blurb => 'Generosa\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6X 0K1'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Seema\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'43 ST and 41 AVE',:slug => 'Seemas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Kiniski Gardens/Burnewood!', :blurb => 'Seema\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6L 6V1'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Analyn\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'21 AVE and 70 ST SW',:slug => 'Analyns day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Summerside!', :blurb => 'Analyn\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6X 0S3'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Vijaya\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Leger Way',:slug => 'Vijayas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Leger!', :blurb => 'Vijaya\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6R 0C2'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Marcy\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'90 AVE and 60 ST',:slug => 'Marcys day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Ottewell!', :blurb => 'Marcy\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6B 1M8'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Meena\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'12 AVE and 110A ST',:slug => 'Meenas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Twin Brooks!', :blurb => 'Meena\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6J 6N6'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Dusanka\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Lorelei Close',:slug => 'Dusankas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Lorelei!', :blurb => 'Dusanka\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T5X 4C3'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Nassra\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'106 AVE and 113 ST',:slug => 'Nassras day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Queen Mary Park!', :blurb => 'Nassra\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T5H 3H6'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Mitra\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Stinson Way',:slug => 'Mitras day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in South Terwillegar!', :blurb => 'Mitra\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6R 0K2'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Bindiya\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'17 AVE and 33B ST',:slug => 'Bindiyas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Laurel!', :blurb => 'Bindiya\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6T 0K5'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_2
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Louisa\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'24 AVE and 83 ST',:slug => 'Louisas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Meyonohk/Lakewood!', :blurb => 'Louisa\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6K 3G8'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Jiken\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Johns Road',:slug => 'Jikens day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Jackson Heights/Burnewood!', :blurb => 'Jiken\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6L 6P3'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Linda\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'35 AVE and 38 ST',:slug => 'Lindas Argyll'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Minchau/Ridgewood!', :blurb => 'Linda\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6L 5Y9'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Agnes\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'187 ST and 70 AVE',:slug => 'Agness day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Lymburn/Callingwood!', :blurb => 'Agnes\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T5T 5C8'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Rekha\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Arurs Crescent',:slug => 'Rekhas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Allard!', :blurb => 'Rekha\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 2H9'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Namarata\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'17 AVE and 61 ST SW',:slug => 'Namaratas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Walker/Ellerslie!', :blurb => 'Namarata\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6X 0M7'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Nilam\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'17 AVE and 61 ST SW',:slug => 'Nilams day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Walker/Ellerslie!', :blurb => 'Nilam\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6X 0M7'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Samjhana\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'140 ST and 159 AVE NW',:slug => 'Samjhanas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Carlton/The Palisades!', :blurb => 'Samjhana\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6V 1V6'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Shirley\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Beaumont',:province =>  'AB',:street2 =>  '',:street1=>'Rideau Crescent',:slug => 'Shirleys day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Beaumont!', :blurb => 'Shirley\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T4X 0B9'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Bimala\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'10 AVE and 59 ST SW',:slug => 'Bimalas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Walker!', :blurb => 'Bimala\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6X 0T1'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Fehmida\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'McPhadden Way',:slug => 'Fehmidas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in MacEwan!', :blurb => 'Fehmida\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 1P8'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Shilpa\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'14 ST and 30 AVE NW',:slug => 'Shilpas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Tamarack!', :blurb => 'Shilpa\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'14th and 30th Ave. NW'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Payal\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'MacEwan Road',:slug => 'Payals day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in MacEwan!', :blurb => 'Payal\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 1R2'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Saba\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'37 AVE and 22 ST',:slug => 'Sabas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Wild Rose!', :blurb => 'Saba\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 0C8'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Gagandeep\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'163 AVE and 65 ST ',:slug => 'Gagandeeps day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Matt Berry!', :blurb => 'Gagandeep\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T5Y 3E4'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Erica\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'17 AVE and 48 ST',:slug => 'Ericas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Pollard Meadows/Southwood!', :blurb => 'Erica\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6L 2X6'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Sophia\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Hammond Crescent',:slug => 'Sophias day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in The Hamptons!', :blurb => 'Sophia\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6M 0K4'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Prabha\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'158 ST and 13 AVE SW',:slug => 'Prabhas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Glenridding Heights!', :blurb => 'Prabha\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 2H5'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Tapasi\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'McPhadden Way',:slug => 'Tapasis day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in MacEwan!', :blurb => 'Tapasi\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 1L3'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Nabila\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'130 AVE and 81 ST',:slug => 'Nabilas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Balwin!', :blurb => 'Nabila\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T5C 1N4'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Nirumpa\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'110 ST and 11A AVE',:slug => 'Nirumpas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Twin Brooks!', :blurb => 'Nirumpa\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6J 6M9'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Harjinder\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'31 ST and 35B AVE',:slug => 'Harjinders day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Wild Rose!', :blurb => 'Harjinder\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6T 1T7'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Lily\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'116 ST and 17 AVE SW',:slug => 'Lilys day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Rutherford!', :blurb => 'Lily\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 1W4'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Anchala\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'28 ST and 16A AVE ',:slug => 'Anchalas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Laurel / the Meadows! ', :blurb => 'Anchala\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6T 0K2'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Mandeep\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Agar Green',:slug => 'Mandeeps day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Allard!', :blurb => 'Mandeep\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 0W8'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_2
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Baljit\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'19 ST and 32 AVE NW',:slug => 'Baljits day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Silver Berry!', :blurb => 'Baljit\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6T 0H3'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Durga\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Loewen Court',:slug => 'Durgas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Leger!', :blurb => 'Durga\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6R 2Y1'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Nery\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Leger Blvd.',:slug => 'Nerys day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Leger!', :blurb => 'Nery\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6R 3J9'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Lola\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'150 AVE and 131 ST',:slug => 'Lolas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Cumberland!', :blurb => 'Lola\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6V 1K3'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Nirmala\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'14 AVE and 53 ST',:slug => 'Nirmalas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Walker!', :blurb => 'Nirmala\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6X 1S2'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Shyamalie\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Schmid Crescent',:slug => 'Shyamalies day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in South Terwillegar!', :blurb => 'Shyamalie\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6R 0K6'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Sangeeta\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'11 AVE and 117 ST SW',:slug => 'Sangeetas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Rutherford!', :blurb => 'Sangeeta\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 1W9'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Kaitlyn\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'118 ST and 9 AVE NW',:slug => 'Kaitlyns day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Twin Brooks!', :blurb => 'Kaitlyn\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6J 7A1'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Shabana\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'76 ST and 38 AVE',:slug => 'Shabanas Millbourne'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Tweddle Place/Millbourne!', :blurb => 'Shabana\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6K 2L6'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Maria-Luisa\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'McMullen Green',:slug => 'Maria-Luisas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in MacEwan!', :blurb => 'Maria-Luisa\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6W 1K8'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Hanjing\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'112 ST and 33 AVE',:slug => 'Hanjings day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Sweet Grass!', :blurb => 'Hanjing\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6J 3X3'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_2
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Huimin\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'68 ST and 19 AVE',:slug => 'Huimins day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Summerside!', :blurb => 'Huimin\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6X 0L8'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_3
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Sana\'s day home',:gmaps =>  true,:licensed=>true,:dietary_accommodations=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Maple Way',:slug => 'Sanas day home'.gsub(' ',''),:email => '', :highlight => 'Quality child care in Maple / the Meadows!', :blurb => 'Sana\'s day home is accredited through Southgate Medallion Family Day Homes—a leader in providing high quality child care and early learning in safe and enriching home settings.

Southgate Medallion Family Day Homes ensures government standards are met or exceeded through detailed safety checks, unannounced home visits and on-going provider support and training. Subsidy is available to families that qualify.

To check availability of child care spaces, please call: 780-438-4012; or click on the “Contact Day Home” link below.

.',:postal_code=>'T6T 0T4'})
      d.availability_types << fully
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << level_1
      d.certification_types << bfa
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
    end    
  end
end