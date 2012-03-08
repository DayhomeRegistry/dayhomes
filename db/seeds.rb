# Destroy all existing dayhomes
DayHome.destroy_all

# Reset the primary key increment count; so it starts counting from 1 again.
DayHome.connection.execute('ALTER TABLE day_homes AUTO_INCREMENT = 1')

addresses_hash = [
  {:postal_code => 'T5N1Y6', :street1 => '131 St NW'},
  {:postal_code => 'T5S1R5', :street1 => '178 St NW'},
  {:postal_code => 'T6C0P9', :street1 => '79 Avenue Northwest'},
  {:postal_code => 'T5E4E5', :street1 => '128 Avenue Northwest'},
  {:postal_code => 'T5E4E5', :street1 => '8638 81 Street'}
]

# Create a couple of dayhomes
addresses_hash.each_with_index  do |street_and_postal, index|
  DayHome.create!({:name => "DayHome #{index}",
                   :gmaps =>  true,
                   :city =>  'Edmonton',
                   :province =>  'AB',
                   :street2 =>  '',
               }.merge(street_and_postal))
end
