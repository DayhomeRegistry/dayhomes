FactoryGirl.define do
  factory :day_home do
    name 'Awesome Day Home'
    slug 'awesome_day_home'
    gmaps true
    featured true
    city 'Edmonton'
    province 'AB'
    street1 '793 blackburn place'
    street2 ''
    email 'email@dayhomeregistry.com'
    postal_code 'T6W1C3'
    phone_number '780-555-5555'
    blurb 'This is a blurb describing this dayhome'
    licensed false
  end
end