# Destroy all the things
AvailabilityType.destroy_all
DayHomeAvailabilityType.destroy_all
CertificationType.destroy_all
DayHomeCertificationType.destroy_all
DayHome.destroy_all
User.destroy_all

# Reset the primary key increment count; so it starts counting from 1 again.
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
fulltime = AvailabilityType.create!({:kind => 'Full-time'})
parttime = AvailabilityType.create!({:kind => 'Part-time'})
no_availability = AvailabilityType.create!({:kind => 'No Availability'})

# address hashes
fulltime_addresses = [
  {:postal_code => 'T5N1Y6', :street1 => '131 St NW'},
  {:postal_code => 'T5S1R5', :street1 => '178 St NW'},
  {:postal_code => 'T6C0P9', :street1 => '79 Avenue Northwest'},
  {:postal_code => 'T5E4E5', :street1 => '128 Avenue Northwest'},
  {:postal_code => 'T5E4E5', :street1 => '8638 81 Street'}
]

part_time_addresses = [
    {:postal_code => 'T6W1C3', :street1 => '793 blackburn place'},
    {:postal_code => 'T6L5M6', :street1 => '4138 36st NW'}
]

no_availability_addresses = [
    {:postal_code => 'T6J5M5', :street1 => '2978 106 Street NW'},
    {:postal_code => 'T5S1S5', :street1 => '10070 178 Street NW'}
]

# Create a couple of dayhomes with full time
fulltime_addresses.each_with_index  do |street_and_postal, index|
  d = DayHome.create!({:name => "DayHome #{index}",
                   :gmaps =>  true,
                   :city =>  'Edmonton',
                   :province =>  'AB',
                   :street2 =>  ''
               }.merge(street_and_postal))

  d.availability_types << fulltime
  d.certification_types << level_1
  d.certification_types << level_2
  d.certification_types << advanced_cpr
  if index.odd?
    d.availability_types << parttime
    d.certification_types << level_3
    d.certification_types << infant_cpr
  end
end

# Create a couple of dayhomes with part time
part_time_addresses.each_with_index  do |street_and_postal, index|
  d = DayHome.create!({:name => "DayHome #{index}",
                   :gmaps =>  true,
                   :city =>  'Edmonton',
                   :province =>  'AB',
                   :street2 =>  ''
                  }.merge(street_and_postal))
  d.availability_types << parttime
  d.certification_types << basic_cpr
end

# Create a couple of dayhomes with no availability
no_availability_addresses.each_with_index  do |street_and_postal, index|
  d = DayHome.create!({:name => "DayHome #{index}",
                       :gmaps =>  true,
                       :city =>  'Edmonton',
                       :province =>  'AB',
                       :street2 =>  ''
                      }.merge(street_and_postal))
  d.availability_types << no_availability
  d.certification_types << advanced_cpr
end


# Destroy all existing users
User.destroy_all

# Reset the primary key increment count; so it starts counting from 1 again.
User.connection.execute('ALTER TABLE users AUTO_INCREMENT = 1')

# Create Default Admin User
User.create!({:email => 'dayadmin@dayhomeregistry.com', :password => 'day4admin', :password_confirmation => 'day4admin', :first_name => 'DayHome', :last_name => 'Admin', :admin => true})




