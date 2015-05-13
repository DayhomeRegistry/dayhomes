#encoding: utf-8 
namespace :db do
  

  namespace :seed do
    task :northalta => :environment do
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
          { :caption => "Northalta", :photo => "northalta.png"}
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
      full_time_full_days = AvailabilityType.where({:availability => 'Full-time', :kind => 'Full Days'}).first


      org = Organization.find_by_id(480)
      location = Location.find_by_id(483)

      d=DayHome.create!({:name => 'Achol\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'136 AVE and 24 ST',:slug => 'Achol'.gsub(' ',''),:email => '', :highlight => 'Achol is located on 136 Avenue and 24 Street and joined Northalta in 2014.', :blurb => 'She has a Child Development Assistant certificate. Prior to opening her day home she worked in day care centres and taught Sunday school in Africa. Achol’s day home is set up on the main floor of her home and she has a separate bedroom just for napping. A regular day for the children in the day home include: circle time, arts and crafts, song and dance, reading time and outdoor play. Parents and children enjoy Achol and even the most nervous/shy child quickly warms up to her quickly. Achol offers a pet free and smoke free home. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T5A 3S7'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Marie\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'85 ST and 24 AVE',:slug => 'Marie'.gsub(' ',''),:email => '', :highlight => 'Marie joined Northalta in 2011 with her Child Development Assistant certificate.', :blurb => 'Prior to opening a day home with Northalta, Maria operated a day home privately for many years before and was a teacher in her home country of St. Lucia. Marie’s day home is set up on the lower level of her day home and she has a separate room for the children to nap in. Her space is very inviting with lots of posters on the wall and large south facing windows that allow a lot of sunlight in. Marie has a variety of toys and equipment for the children to play with and her daily routine with the children includes dance and music, storytelling, arts and crafts and pretend play. Marie also has an enormous, fenced backyard for the children to play in. Marie is energetic and upbeat with the children and encourages their input into the program. Please call Northalta at 780 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6K 2W3'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Beth\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'160 ST and 87 AVE',:slug => 'Beth'.gsub(' ',''),:email => '', :highlight => 'Beth is located at 160 Street and 87 Avenue; Lilybeth joined Northalta in 2013 and has a  Child Development Supervisor Certificate.', :blurb => 'Before opening her day home Lilybeth raised a child of her own and worked in daycare centers’. Lilybeth has set the day home up on the main floor of her home. She lots of toys and equipment for the children to use and they are stored at the children’s level. Her walls are bright and cheery and she puts pictures of the children and their families up so all the children feel welcomed. Lilybeth enjoys taking the children outside in all weather and her back yard has great equipment to play with. Lilybeth is very calm and quiet in her approach with children which helps children feeling nervous or uneasy. Lilybeth regularly communicates with parents through text messaging and is happy to send you daily updates and pictures of your child. Lilybeth is a kind and caring provider that will go above and beyond to make your child feel special. Please call Northalta at 780 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T5R 4G9'})
      d.availability_types << full_time_full_days
      d.certification_types << level_3
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Freda\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'174 AVE and 95 ST ',:slug => 'Freda'.gsub(' ',''),:email => '', :highlight => 'Freda is located at 174 Ave and 95 Street.', :blurb => 'Freda has been a provider with our agency since 2012 – she has two children of her own. Freda has done an excellent job maximizing the space for the children. Freda has wonderful programming and she gets the children and families input when considering her programming. Freda include daily outdoor activities into her programming, weather permitting. The families at Freda’s day home always have positive feedback a and the children are always laughing and having a good time when our home visitors are out to visit. Freda’s preferred hours are 6AM – 6PM. Please call Northalta at 780 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T5Z 2B1'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Davorka\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'165 AVE and 88 ST',:slug => 'Davorka'.gsub(' ',''),:email => '', :highlight => 'Davorka is located in a house on 165 avenue and 88 street.', :blurb => 'Davorka joined Northalta in 2012 and has her Child Development Worker Certificate. She has many years of child care experience working in day cares and day homes. Davorka is very organized and has her day home completely set up on the lower level of her home just for children. She uses her back deck and the park for outdoor play. She is artistically creative which is evident when visiting her home; ask to see some of the children’s artwork and pictures that she displays throughout the space. Please call Northalta at 780 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T5Z 3W9'})
      d.availability_types << full_time_full_days
      d.certification_types << level_2
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Harvir\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'30th ST and 26th AVE NW',:slug => 'Harvir'.gsub(' ',''),:email => '', :highlight => 'Harvir is located in a house on 26 avenue and 30 street and she contracted with Northalta in 2013.', :blurb => 'She has a Child Development Worker certificate and attends recommended workshops and conferences and has a good understanding of children’s needs. She uses the lower level of her home for the day home which has natural light and a lot of play space and a separate napping area. She provides a non pet and non smoking environment. She has a large back yard that she uses for outdoor play. Harvir roles models environmental awareness to the children by re-using household materials to teach children colors and shapes, and has numerous multicultural items throughout the day home. Harvir was visited by our Government of Alberta contract specialist in 2014 and her report noted her positive and educational interactions with children. She helps children verbalize and connect with everything they see! Please call Northalta at 780 448-1301 or visit our website www.northaltacare.com for further information',:postal_code=>'T6T 0H6'})
      d.availability_types << full_time_full_days
      d.certification_types << level_2
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Parminder\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'2nd AVE and 54th ST  SW',:slug => 'Parminder'.gsub(' ',''),:email => '', :highlight => 'Parminder’s day home is located on 2nd Avenue and 54th Street SW.', :blurb => 'She joined Northalta in 2014 and has a Child Development Supervisor certificate. Prior to opening her day home Parminder worked in Preschool and Out of School Care environments. Her day home is set up on the lower level of her home. Parminder plans an exciting program for the children that include daily arts, crafts, fine motor play, outdoor play and pretend play. Children and families feel comfortable in her day home because they feel welcomed by Parminder and her family. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6X 0L4'})
      d.availability_types << full_time_full_days
      d.certification_types << level_3
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Alma\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'68th ST and 29th AVE',:slug => 'Alma'.gsub(' ',''),:email => '', :highlight => 'Alma is located on 68th Street and 29th Avenue.', :blurb => 'She joined Northalta in 2015 with a Child Development Supervisor certificate. Prior to opening a day home Alma worked for various day care and preschool programs including a Waldorf program which has inspired the design of her day home. The day home is set up on the main floor of Alma’s day home and has many plants, a water fountain and a large tropical aquarium the children help care for. Alma has a “life experiences” area in her day home where children can practice skills needed in everyday life, like lacing shoes, using utensils and dressing with buttons and zippers. Alma offers a practical, developmentally appropriate program based on each child’s unique interests and abilities. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6K 1N6'})
      d.availability_types << full_time_full_days
      d.certification_types << level_3
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Colleen\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'32 AVE and 35 ST NW',:slug => 'Colleen'.gsub(' ',''),:email => '', :highlight => 'Colleen is located in a house on 35 street and 32 avenue.', :blurb => 'She joined Northalta in 2006 and completed the Northalta Provider Training program and a food handling course. Her day home is set up on the lower level of her house and is dedicated to children. She provides a loving environment with busy activities for children. Colleen is naturally a very kind, patient and energetic person and likes to do different activities including taking children outside and exploring the community. Colleen has 2 older children of her own and is aware of the needs of each individual child. Colleen works with parents to ensure the children’s needs are met. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6L 5J2'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Sabrina\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'164th AVE and 106 ST NW',:slug => 'Sabrina'.gsub(' ',''),:email => '', :highlight => 'Sabrina is located in a  house on 164 avenue and 106 street.', :blurb => 'She joined Northalta in 2010, and has 3 children of her own. She has a Bachelor of Education with an Elementary focus and also has a Child Development Supervisor certificate . Sabrina has a lovely day home set up on the lower level of her home and she uses her education to create a learning environment for children including circle time and different activity centers for full day routine. Sabrina is very organized, patient, and provides a non smoking environment. She accommodates children’s transportation needs to and from school when needed. **She has 2 toy poodle dogs. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T5X 1W4'})
      d.availability_types << full_time_full_days
      d.certification_types << level_3
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Michelle\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'34th ST and 21 Ave NW',:slug => 'Michelle'.gsub(' ',''),:email => '', :highlight => 'Michelle is located on 32 Street and 21 Avenue.', :blurb => 'She joined Northalta in 2012 and has her Child Development Assistant certificate. Her experience with children comes from raising two children of her own and working with children in formal settings including a pre-school and she naturally connects and interacts with children. Michelle’s day home is set up on the main level of her home but has a separated napping area on the upper level. She enjoys doing crafts with the children and also gives them time to explore and play with toys that interest them. She also includes outside play in the children’s daily routine. Michelle is very focused on keeping children healthy and happy. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6T 0K9'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Belen\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'113 ST and 40th AVE NW',:slug => 'Belen'.gsub(' ',''),:email => '', :highlight => 'Belen is located on 113 Street and 40 Avenue and she  joined Northalta in 2010 with a Child Development Assistant certificate.', :blurb => 'Before opening her own day home Belen worked in day care centers; she has over 20 years of experience with children. Her day home is set up on the lower level of her home, and she decorates her walls with pictures of the children and their art work. The children at Belen’s are always busy playing and learning; Belen has a great variety of indoor/outdoor toys and equipment for the children to play with. In the winter Belen spends a lot of time with the children on arts and crafts, dramatic play and song and dance. During the long days of summer Belen loves to take the children outside for raspberry picking, neighborhood walks and picnics at the local spray park. The children and families that attend Belen’s day home quickly feel welcomed and valued; Belen takes time to talk with families each day about their child’s development and plans meaningful experiences that compliment the child’s home life experiences. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6G 0R2'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Aneeza\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'152 avenue and Castle Downs Road',:slug => 'Aneeza'.gsub(' ',''),:email => '', :highlight => 'Aneeza  lives in a town home near 152 avenue and Castle Downs Road and joined Northalta in 2015 after completing early childhood training.', :blurb => 'She uses the main floor and lower level for a variety of children’s activities. She has created centers for the children to enjoy and will expand them based on the children’s needs and interests. She understands learning should be fun and meaningful for children and understands the needs of parents and children. Aneeza has a backyard with room for the children to enjoy different activities outdoors. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further informatio',:postal_code=>'T5X 2E6'})
      d.availability_types << full_time_full_days
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Sahar\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'80th ST and 15A AVE NW',:slug => 'Sahar'.gsub(' ',''),:email => '', :highlight => 'Sahar is located in a house on 80 street and 15A avenue and joined Northalta in 2013.', :blurb => 'She is a Child Development Supervisor. Sahar has created a child friendly environment on the lower level of her home and has a large back yard for daily outdoor activities. She also visits parks and playgrounds around her area and understands the importance of outdoor play. Sahar is energetic and works with parents to ensure the child and the parents needs are met. She can sometimes accommodated early morning arrivals and later evening pickups if requested. Sahar works hard to keep a balanced menu for all children, and serves nutritious meals and snacks. She also has a very supportive family of her own which creates a family friendly day home. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6K 4E3'})
      d.availability_types << full_time_full_days
      d.certification_types << level_3
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Marion\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'162 AVE and 109 ST NW',:slug => 'Marion'.gsub(' ',''),:email => '', :highlight => 'Marion lives in a duplex on 109 street and 162 avenue.', :blurb => 'She joined Northalta in 1999. Marion has a Child Development Supervisor certificate. She uses the main level of her home for her day home and has been creative in maximizing her space to create different play environments. She observes children’s interests and then plans their daily activities to include dramatic play, quiet time, reading, crafts, puppet theatre, etc. For outside play, Marion uses her back yard and also goes on regular walks around the neighborhood. Marion knows the value of professional development and attends conferences and workshops whenever possible. She provides a non smoking and pet friendly house and has a dog that she carefully supervises when around children. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T5X 2P9'})
      d.availability_types << full_time_full_days
      d.certification_types << level_3
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Maria\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'35th AVE and 79 ST NW',:slug => 'Maria'.gsub(' ',''),:email => '', :highlight => 'Maria lives on 35 avenue and 79 street and  has provided excellent child care for Northalta since 2008 and has a Child Development Worker certificate and has also worked in a day care center.', :blurb => 'She lives in a 4-plex, with the day home set up on the main level where lots of natural light enters the play space. Her main floor is dedicated only to the day home and has different activity centers set up based on each child’s interests and needs. Maria’s back yard is enclosed with numerous outdoor activities to keep the children engaged. Maria has an strong relationship with the parents and works with both the parents and the children to help their development. She is very patient with the children as they develop their needs and enter different stages and works hard to ensure all their nutritional needs are met. 
      ***Note: Maria will be moving to Ellerslie area this summer. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further informatio',:postal_code=>'T6K 0C5'})
      d.availability_types << full_time_full_days
      d.certification_types << level_2
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Elizabeth\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>' Dewolf RD NW',:slug => 'Elizabeth'.gsub(' ',''),:email => '', :highlight => 'Elizbieta (Elizabeth) is located in the Griesbach area.', :blurb => 'She joined Northalta in 2004 with a Child Development Supervisor certificate and was awarded the Alberta Child Care Professional Awards of Excellence in 2007. She is originally from Poland and was a practicing teacher there before moving to Canada and operating a day care centre. When Elzbieta decided to open her own day home she says “it was the best choice I ever made”. She moved to her current location in 2014 and made her brand new day home even better for children! It is set up on the lower level and everything is new and modern and laid out similar to a day care with tons of toys and activities for children. She regularly takes children on field trips and neighborhood walks and understands the importance of outdoor play experiences. Elzbieta has a big focus on learning about other cultures and provides numerous opportunities for the children to try different food, songs, dance and dress up from different countries. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T5E 6R4'})
      d.availability_types << full_time_full_days
      d.certification_types << level_3
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Raman\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'33ST and 16B AVE NW',:slug => 'Raman'.gsub(' ',''),:email => '', :highlight => 'Raman lives in a house on 33 street and 16B avenue.', :blurb => 'She joined Northalta in 2013 and has a Child Development Worker Certificate. Raman is currently continuing her education. Raman provides a non-pet, non-smoking environment and has created a child friendly environment on the upper level of her home where there is plenty of natural light. She understands the importance of outdoor play and is currently using her enclosed deck for the children until her fence is completed. Raman has a calm demeanor, is pleasant to talk to and works well with Northalta and the families ensuring the future success of all children. Raman observes the children’s needs and interests and then creates a balanced program and menu plan based on their needs. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6T 0P1'})
      d.availability_types << full_time_full_days
      d.certification_types << level_2
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Raj\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'11AVE and 61ST SW',:slug => 'Raj'.gsub(' ',''),:email => '', :highlight => 'Rajwinder (Raj) is located on 61 street and 11 avenue SW.', :blurb => 'She joined Northalta in 2014 and has a Child Development Assistant certificate. Raj’s experience comes from raising her own daughter and caring for friends and families children. Her day home is set up on the main and upper levels of her home; upstairs is for playing with toys, building with blocks, reading books, and a separate room for nap time. The main level is for eating and doing messy activities like painting, gluing and Playdoh. Raj uses her un-gated backyard for outdoor play and the children especially enjoy her bouncy castle. Raj is friendly and children quickly warm up to her and will make you and your child feel welcomed! Raj’s daughter is also excited to have friends to share her home with. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6X 0M4'})
      d.availability_types << full_time_full_days
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Suzana\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'95ST and 63rd AVE NW',:slug => 'Suzana'.gsub(' ',''),:email => '', :highlight => 'Suzana lives in a house on 95 street and 63 avenue.', :blurb => 'She has been with Northalta since 1995. She is originally from Serbia. Suzana’s lower level is completely set up for children. Suzana believes in the importance of outdoor play, she has a large back yard and also visits parks and playgrounds in the area on a regular basis. Suzana treats children as if they her own, and serves very nutritious meals and snacks and follows the Canadian food guide while creating these meals (example: stews, soups, hot sandwiches, etc.). She provides a non-smoking environment. She has a small family dog who is not around children. Suzana has a very supportive family and are very helpful. The Agency receives great feedback on Suzanna\'s home. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6E 0M4'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Shirley\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'159th ST and 108 AVE NW',:slug => 'Shirley'.gsub(' ',''),:email => '', :highlight => 'Shirley is located on 159 Street and 108 Avenue.', :blurb => 'She joined Northalta in 1992, has a Child Development Assistant certificate and participates in all recommended professional training opportunities. Shirley’s day home is set up on the main level of her home and is separated from the rest of her house. Shirley decorates her day home with pictures of the children and their families and displays their art work too. Shirley has a large selection of toys and equipment for children and each child has their own locker to store their items for home time. Shirley’s daily routine includes, arts, crafts, outdoor exercise, song, dance and dramatic play. She regularly plans field trips to local sites and attractions, her most recent trips being to the Fire Hall, Build a Bear, and the Library. Shirley sends all the families daily reports via The Daily Child Care Report where parents can access though email or text message so they can see exactly what their child is/doing doing. *Shirley has three small dogs in her home. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T5P 1A9'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Ambreen\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'2nd AVE and 85 ST  SW',:slug => 'Ambreen'.gsub(' ',''),:email => '', :highlight => 'Ambreen lives in a 2 storey home on 2 avenue and 85 street SW.', :blurb => 'She joined Northalta in 2014 and has two children of her own that love sharing their home with their day home friends. She uses her main floor for the day home and has created centers for children to enjoy. Ambreen is soft spoken , and she understands the importance of literacy in the children’s daily activities and she plans activities that make learning fun and interesting. Ambreen has a large back yard with ample room for the children to enjoy many outdoor activities and she has a separate sleep area so that the children get the rest they need. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6X 1H5'})
      d.availability_types << full_time_full_days
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Chhaya\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'21 AVE and 28 ST NW',:slug => 'Chhaya'.gsub(' ',''),:email => '', :highlight => 'Chhaya is located at 21 Avenue and 28 Street.', :blurb => 'She joined Northalta in 2014 and has a Child Development Assistant certificate. Chhaya has two daughters of her own and has prior experience caring for friends and families children as well. Chhaya offers an open concept play space on the main floor of her home and this is where most of the activities take place; arts, crafts, building with blocks, reading books, games, song and dance. Chhaya also offers a separate room on her upper level for napping. Chhaya’s backyard is fenced and she takes children outside to play. Chhaya is extremely accommodating to the children and families in her program and goes above and beyond to make families feel welcomed and comfortable. Personally, Chhaya is a vegetarian although she has expressed she will serve the children meat dishes if brought from home. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6T 0K1'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Yashvant\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'21A  Avenue and 29 Street',:slug => 'Yashvant'.gsub(' ',''),:email => '', :highlight => 'Yashvant  is located on 21A  Avenue and 29 Street.', :blurb => 'She Yashvant joined Northalta in 2015 and came to us with many years of experience. Yashvant has her Child Development Assistant certificate and offers a pet free and smoke free home. Her day home is set up on the main level and has a separate area for napping. A regular day for the children in Yashvant ’s day home include circle time, reading, arts, crafts, song, dance and outdoor play. Yashvant likes to take care of her families and ensures that this is done by open communication with the parents and the agency. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6T 0K3'})
      d.availability_types << full_time_full_days
      d.certification_types << crc
      d.certification_types << cwc
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Alicja\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'149th AVE and 134th ST NW',:slug => 'Alicja'.gsub(' ',''),:email => '', :highlight => 'Alicia is located at 149 avenue and 134 street.', :blurb => 'She joined Northalta in 1999 and has a Child Development Assistant certificate and continues her professional development by regularly attending the Annual Provider Conference and Agency workshops. Her day home is set up on the lower level of her home with a private entrance. The lower level walks right out into the backyard which has plenty of equipment for the children to use. The children choose from a variety of meaningful activities that meet their interests, as well as Alicia doing crafts and reading with them. Alicia is originally from Poland and teaches children the Polish language and culture.Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6V 1L1'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Nilima\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Alexander Way SW',:slug => 'Nilima'.gsub(' ',''),:email => '', :highlight => 'Nilima is located on Alexander Way (SW).', :blurb => 'She joined Northalta in 2015 and has her Child Development Worker certificate. Before joining Northalta Nilima worked in a day care as the program leader and also has experience from raising two of her own sons. Nilima’s day home is set up on the main level and upper level of her home and she has a separate room for naps so all age groups can be accommodated. Nilima uses the main level of her home for snacks and messy play and the upstairs for pretend play, games and puzzles and story time. Nilima is a young, energetic and loving provider with creative programming ideas, she listens carefully to families and works hard to create the type of learning they want for their child. Nilima helps children develop independence by encouraging them to try new things in a safe and supported environment. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6W 2C5'})
      d.availability_types << full_time_full_days
      d.certification_types << level_2
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Aida\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Hollinger Close NW',:slug => 'Aida'.gsub(' ',''),:email => '', :highlight => 'Aida is located in Hollinger Close.', :blurb => 'She joined Northalta in 2007 and she has her Child Development certificate and continues her professional development by attending the annual provider conference and Northalta workshops. Her day home is set on the main floor of her home and she has a great variety of toys and equipment for the children to enjoy. She will often incorporate Spanish into the children’s learning, but Aida understands the individual needs and interests of all children. She is a great child care choice Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T5A 5E8'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Rubenia\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'121 AVE and 80th ST NW',:slug => 'Rubenia'.gsub(' ',''),:email => '', :highlight => 'Rubenia lives in a house on 121 avenue and 80 street.', :blurb => 'She joined Northalta in 2011 and has her Child Development Assistant certificate. Rubenia came to Northalta from a nearby day care and the parents and staff we spoke to LOVED Rubenia! Rubenia has her day home completely set up like a little day care which was renovated for the day home and is separate from the living area of her home. Rubenia is very involved in the children’s play and does programming based on the interests and needs of the children in care. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6B 2P2'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Tracy\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'12th AVE and 72nd ST NW',:slug => 'Tracy'.gsub(' ',''),:email => '', :highlight => 'Tracy lives in a house on approximately 12 avenue and 72 street.', :blurb => 'Tracy joined Northalta in 2007 and has been continuing her education ever since, she achieved her Child Development Assistant certificate and is currently working towards her Child Development Worker Certificate. The day home is set up on the main level of the home, as well as the second level (it is a split-level home). Tracy takes the children outside regularly whether it is a short walk to the neighborhood school park, or in her own beautiful “park-like” yard! Tracy understands the importance of good nutrition and feeds the children appropriate healthy meals and snacks, as well as understands the developmental needs of each individual child and caters her programming appropriately based on your child’s wants and needs. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6K 2S9'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Felipa\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'69th ST and 162nd AVE NW',:slug => 'Felipa'.gsub(' ',''),:email => '', :highlight => 'Felipa is located at 69 Street and 162 Avenue.', :blurb => 'Felipa has been with Northalta since 2002 and prior to joining Northalta Felipa operated her day home with another day home agency and years before that worked in daycare. Felipa has her Child Development Certificate training and attends various training and workshop opportunities to remain current and informed on childcare topics. Felipa’s day home is mostly set up on the lower level of her home although the children do eat in her kitchen area, on the main floor. Felipa’s day home space is bright and cheery with a lot of toy selection for the children to choose from. Felipa’s daily routine includes messy play (painting, playdoh, baking), outdoor play, song and dance and pretend play. Felipa also offers programming in English/Spanish and many of the children in her day home are learning to speak Spanish. Felipa offers a very active, busy environment with lots of love and laughs in her home. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T5Z 3B2'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Heather\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'149th AVE and 96th ST NW',:slug => 'Heather'.gsub(' ',''),:email => '', :highlight => 'Heather is located in a house on 149 avenue and 96 street and has been with Northalta since 2005.', :blurb => 'She has completed her diploma in child care through Red Deer College and obtained her Child Development Supervisor certificate and usually has a full day home. Heather is constantly striving to be the best day home and accommodates all standards, policies, and best practices. She seeks out new training opportunities and attends most workshops and conferences put on by Northalta and the Child Care ministry. Heather provides a non pet and non smoking environment and is truly in tune to children’s needs and provides lots of activities through active programming and educational activities; she also has a variety of equipment for a variety of children’s ages and stages. She speaks some Arabic and enjoys teaching the children some of the words she knows and she includes multicultural programming in most activities. She also has excellent references available upon request.Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T5E 4W7'})
      d.availability_types << full_time_full_days
      d.certification_types << level_3
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Runa\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Millbourne RD West NW',:slug => 'Runa'.gsub(' ',''),:email => '', :highlight => 'Runa  lives just off on 39 ave and 89 street.', :blurb => 'She lives on the ground level of a condo and parents access through her patio doors, as you walk in the patio doors you enter right into her day care setup. Runa has her Child Development Certificate and has numerous years of day home and day care experience. Her play space will show you that she has a great understanding of the children’s needs in her care. Runa has a green space for the children to play outside of her day home and a outdoor park that is in walking distance to ensure the children have outdoor play each day. There are plenty of toys and activities for the children to play with and she has created a very cheery and bright space. Runa comes to us with amazing references from prior families in her care. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6K 3B4'})
      d.availability_types << full_time_full_days
      d.certification_types << level_3
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Agnes\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Queen\'s Court NW',:slug => 'Agnes'.gsub(' ',''),:email => '', :highlight => 'Agnes lives in a townhouse just off 122 street and 43 A avenue.', :blurb => 'Agnes has been with Northalta since September 2013 and loves to operate a day home, Agnes has her child development supervisor certificate. Agnes has over 20 years of different experiences including a teachers certificate, bachelor of education degree and she writes children’s books; 5 of which have been published in her Ghana language. She has created a child friendly space with a reading, dramatic play, kitchen and music center for the children, she uses music and instruments to help teach the children. Ask her to show you this area, you will not be disappointed. She also has a variety of other easily accessible toys for the children. She also understands the importance of outdoor play and uses the green space and the local park/splash park a lot in the summer time. Agnes is friendly, welcoming, pleasant, and has a wonderful smile, she works well with the Agency and parents to ensure each child’s needs are met. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6J 2E3'})
      d.availability_types << full_time_full_days
      d.certification_types << level_3
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Jessica\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'135th AVE and 69th ST NW',:slug => 'Jessica'.gsub(' ',''),:email => '', :highlight => 'Jessica is located on 135 avenue and 69 street and she  joined Northalta in 2014.', :blurb => 'She is currently working towards her Child Development Assistant certificate. Jessica has worked in Daycare and Preschool settings and when you see her play space you notice that she has incorporated what she has learned into her home for her two children. Jessica has her day home set up on both the upper and the lower level of her home. Upstairs is where the messy crafts, fish watching and eating takes place and downstairs there is plenty of toys and activities for the children to stay engaged. Jessica is currently renovating her back yard and daily she uses a large green space right across the street from her. Jessica prepares all the meals and snacks for the children in her day home and offers nutritious, homemade foods. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T5C 0H7'})
      d.availability_types << full_time_full_days
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Annie\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'Kensit Place NW',:slug => 'Annie'.gsub(' ',''),:email => '', :highlight => 'Annie is located on approximately 34 street and 37 avenue.', :blurb => 'Annie joined Northalta in 2006. She has her Child Development Assistant certificate and an education background in health and nutrition. Her day home is set up in a nice large open area on the main floor of her home. She has a room on the main floor that is dedicated to the children with pictures and art work on the walls. Annie is very interactive with the children and uses “teachable moments” to expand on children’s interests., Annie works with parents to help meet the children’s needs. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6L 6X6'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Boi\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'120th AVE and 49th ST NW',:slug => 'Boi'.gsub(' ',''),:email => '', :highlight => ' Boi  lives in a house on approximately 120 avenue and 49 street.', :blurb => 'She has her level 3 “Child Development Supervisor” certificate, and worked in high quality day cares for many years; she worked in the infant rooms, and the parents and staff had excellent references to give for Boi. Boi is very conscious when it comes to organization and planning and she is very aware of sanitary health practices, and keeps the toys and play areas clean and disinfected. She communicates daily with parents on arrival and departure to ensure the needs and expectations are being met. Boi really enjoys younger children. She plans a fun learning based program designed to enhance children’s individual and developmental needs and interestsPlease call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T5W 3A3'})
      d.availability_types << full_time_full_days
      d.certification_types << level_3
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Parminder\'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'33rd ST and 32nd AVE NW',:slug => 'Parminder33'.gsub(' ',''),:email => '', :highlight => 'Parminder lives in a house on 33 street and 32 avenue .', :blurb => 'She joined Northalta in 2013 and has her Child Development Supervisor certificate. Parminder uses the lower level of her home for the day home and has a walk-out basement; parents enter from the back entrance. The whole lower level belongs to the day home and has a beautiful window that allows in plenty of natural light and looks out over a lake. She has a good variety of toys and purchases new equipment based on the ages and needs of the children that register for her day home. Parminder has a big back yard with plenty of equipment for the children to play with, this year she devoted an area of her yard so the children could help grow some herbs to use in their meals. Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6T 1X7'})
      d.availability_types << full_time_full_days
      d.certification_types << level_3
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
      d=DayHome.create!({:name => 'Lei \'s Dayhome',:gmaps =>  true,:licensed=>true,:city =>  'Edmonton',:province =>  'AB',:street2 =>  '',:street1=>'19th AVE and 119th ST SW',:slug => 'Lei '.gsub(' ',''),:email => '', :highlight => 'Lei lives in a home on 19 avenue and 119 street SW.', :blurb => 'She joined Northalta in 2014. She has a very She has a very cheery and bright space indoors with a nice selection of toys and resources on the main level of her home. Lei continues to add to her day home based on the needs and interests of the children. She uses the upstairs for naps, and has created a separate craft area and eating area. She understands the importance of keeping children busy and active! Please call Northalta at 780 - 448-1301 or visit our website www.northaltacare.com for further information.',:postal_code=>'T6W 0E1'})
      d.availability_types << full_time_full_days
      d.certification_types << level_1
      d.certification_types << crc
      d.certification_types << cwc
      d.certification_types << icpr
      add_photos_to_dayhome(photos, d)
      location.day_homes << d
      location.save
      puts 'Created '+d.name
    end    
  end
end