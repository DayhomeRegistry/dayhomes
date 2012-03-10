# Destroy all existing dayhomes - availabilty
DayHome.destroy_all
Availability.destroy_all

# Reset the primary key increment count; so it starts counting from 1 again.
DayHome.connection.execute('ALTER TABLE day_homes AUTO_INCREMENT = 1')
Availability.connection.execute('ALTER TABLE availability AUTO_INCREMENT = 1')

Availability.create!{:type => 'full-time'}
Availability.create!{:type => 'part-time'}
Availability.create!{:type => 'no availability'}

# address hashes
enrolled_address_hash = [
  {:postal_code => 'T5N1Y6', :street1 => '131 St NW'},
  {:postal_code => 'T5S1R5', :street1 => '178 St NW'},
  {:postal_code => 'T6C0P9', :street1 => '79 Avenue Northwest'},
  {:postal_code => 'T5E4E5', :street1 => '128 Avenue Northwest'},
  {:postal_code => 'T5E4E5', :street1 => '8638 81 Street'}
]

enrollment_closed_address_hash = [
    {:postal_code => 'T6@1C3', :street1 => '793 blackburn place'},
    {:postal_code => 'T6L5M6', :street1 => '4138 36st NW'}
]

# Create a couple of dayhomes with open enrollment
enrolled_address_hash.each_with_index  do |street_and_postal, index|
  DayHome.create!({:name => "DayHome #{index}",
                   :gmaps =>  true,
                   :city =>  'Edmonton',
                   :province =>  'AB',
                   :street2 =>  ''
               }.merge(street_and_postal))
end

# Create a couple of dayhomes with open enrollment
enrollment_closed_address_hash.each_with_index  do |street_and_postal, index|
  DayHome.create!({:name => "DayHome #{index}",
                   :gmaps =>  true,
                   :city =>  'Edmonton',
                   :province =>  'AB',
                   :street2 =>  ''
                  }.merge(street_and_postal))
end


# Create Default Admin User
User.create!({:email => 'dayadmin@dayhomeregistry.com', :password => 'day4admin', :password_confirmation => 'day4admin', :first_name => 'DayHome', :last_name => 'Admin', :admin => true})




