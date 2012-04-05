# Destroy all the things
AvailabilityType.destroy_all
DayHomeAvailabilityType.destroy_all
CertificationType.destroy_all
DayHomeCertificationType.destroy_all
Review.destroy_all
DayHome.destroy_all
User.destroy_all


# Reset the primary key increment count; so it starts counting from 1 again.
User.connection.execute('ALTER TABLE users AUTO_INCREMENT = 1')
DayHome.connection.execute('ALTER TABLE day_homes AUTO_INCREMENT = 1')
AvailabilityType.connection.execute('ALTER TABLE availability_types AUTO_INCREMENT = 1')
CertificationType.connection.execute('ALTER TABLE availability_types AUTO_INCREMENT = 1')

# create certification types
level_1 = CertificationType.create!({:kind => 'Child Care Level 1'})
level_2 = CertificationType.create!({:kind => 'Child Care Level 2'})
level_3 = CertificationType.create!({:kind => 'Child Care Level 3'})
basic_cpr = CertificationType.create!({:kind => 'Basic First Aid'})
advanced_cpr = CertificationType.create!({:kind => 'Advanced First Aid'})
infant_cpr = CertificationType.create!({:kind => 'Infant CPR'})

# create availability types
full_time_full_days = AvailabilityType.create!({:availability => 'Full-time', :kind => 'Full Days'})
full_time_after_school = AvailabilityType.create!({:availability => 'Full-time', :kind => 'After School'})
full_time_before_school = AvailabilityType.create!({:availability => 'Full-time', :kind => 'Before School'})
part_time_full_days = AvailabilityType.create!({:availability => 'Part-time', :kind => 'Full Days'})
part_time_morning = AvailabilityType.create!({:availability => 'Part-time', :kind => 'Morning'})
part_time_afternoon = AvailabilityType.create!({:availability => 'Part-time', :kind => 'Afternoon'})
part_time_after_school = AvailabilityType.create!({:availability => 'Part-time', :kind => 'After School'})
part_time_before_school = AvailabilityType.create!({:availability => 'Part-time', :kind => 'Before School'})


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
user0 = User.create!({:email => 'test0@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'TestF', :last_name => 'TestL', :admin => false})
user1 = User.create!({:email => 'test1@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'TestF', :last_name => 'TestL', :admin => false})
user2 = User.create!({:email => 'test2@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'TestF', :last_name => 'TestL', :admin => false})
user3 = User.create!({:email => 'test3@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'TestF', :last_name => 'TestL', :admin => false})
user4 = User.create!({:email => 'test4@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'TestF', :last_name => 'TestL', :admin => false})
user5 = User.create!({:email => 'test5@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'TestF', :last_name => 'TestL', :admin => false})
user6 = User.create!({:email => 'test6@test.com', :password => 'pass@word1', :password_confirmation => 'pass@word1', :first_name => 'TestF', :last_name => 'TestL', :admin => false})

users = [ user0, user1, user2, user3, user4, user5, user6]

# address hashes
fulltime_addresses = [
  {:postal_code => 'T5N1Y6', :street1 => '131 St NW'},
  {:postal_code => 'T5S1R5', :street1 => '178 St NW'},
  {:postal_code => 'T6C0P9', :street1 => '79 Avenue Northwest'},
  {:postal_code => 'T5E4E5', :street1 => '128 Avenue Northwest'},
]

part_time_addresses = [
    {:postal_code => 'T6W1C3', :street1 => '793 blackburn place'},
    {:postal_code => 'T6L5M6', :street1 => '4138 36st NW'}
]

no_availability_addresses = [
    {:postal_code => 'T6J5M5', :street1 => '2978 106 Street NW'},
    {:postal_code => 'T5S1S5', :street1 => '10070 178 Street NW'}
]

def add_photos_to_dayhome(photos, day_home)
  puts "Adding photos to #{day_home.name}..."
  photos.map do |photo|
    photo[:photo] = File.open(File.dirname(__FILE__) + "/seeds/dayhomes/" + photo[:photo]) unless photo[:photo].respond_to?(:read)
    photo
  end
  photos.each do |photo|
    day_home.photos.create!(photo)
  end
end

# Create a dayhome with reviews
day_home_with_reviews = DayHome.create!({:name => "DayHome With Reviews",
                       :gmaps =>  true,
                       :city =>  'Edmonton',
                       :province =>  'AB',
                       :street1 => '4138 36st NW',
                       :street2 =>  '',
                       :slug => 'DayHomesWithReviews',
                       :postal_code => 'T6L5M6',
                       :featured => true })
day_home_with_reviews.availability_types << full_time_full_days
photos = [
  { :caption => "Six and counting.", :photo => "counting.jpg"},
  { :caption => "We provide arts and crafts.", :photo => "crayons.jpg"},
  { :caption => "There are activities for all children.", :photo => "playdoe.jpg"},
  { :caption => "Outdoor playground", :photo => "swing.jpg" }
]
add_photos_to_dayhome(photos, day_home_with_reviews)


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
  d = DayHome.create!({:name => "DayHome #{index}",
                   :gmaps =>  true,
                   :city =>  'Edmonton',
                   :province =>  'AB',
                   :street2 =>  '',
                   :slug => "DayHome#{index}single",
                   :featured => true
               }.merge(street_and_postal))

  d.availability_types << full_time_full_days
  d.certification_types << level_1
  d.certification_types << level_2
  d.certification_types << advanced_cpr
  if index.odd?
    d.availability_types << part_time_after_school
    d.certification_types << level_3
    d.certification_types << infant_cpr
  end
  add_photos_to_dayhome(photos, d)
end

# Create a couple of dayhomes with part time
photos = [
  { :caption => "Fun all day long", :photo => "laughing_outside.jpg" },
  { :caption => "Group activities", :photo => "playing_kids.jpg" },
  { :caption => "Homemade lunches", :photo => "mac_and_cheese.jpg" },
  { :caption => "Stimulating activities.", :photo => "lego.jpg" },
]
part_time_addresses.each_with_index  do |street_and_postal, index|
  d = DayHome.create!({:name => "DayHome #{index}",
                   :gmaps =>  true,
                   :city =>  'Edmonton',
                   :province =>  'AB',
                   :street2 =>  '',
                   :slug => "DayHome#{index}partime",
                   :featured => true
                  }.merge(street_and_postal))
  d.availability_types << part_time_morning
  d.certification_types << basic_cpr
  if index.odd?
    d.availability_types << part_time_afternoon
  end 
  add_photos_to_dayhome(photos, d)
end

# Create a couple of dayhomes with no availability
no_availability_addresses.each_with_index  do |street_and_postal, index|
  d = DayHome.create!({:name => "DayHome #{index}",
                       :gmaps =>  true,
                       :city =>  'Edmonton',
                       :province =>  'AB',
                       :street2 =>  '',
                       :slug => "DayHome#{index}noavail"
                      }.merge(street_and_postal))
  d.availability_types << part_time_before_school
  d.availability_types << full_time_after_school
  d.certification_types << advanced_cpr
  if index.odd?
    d.availability_types << part_time_full_days
    d.dietary_accommodations = true
    d.save!
  end
end


