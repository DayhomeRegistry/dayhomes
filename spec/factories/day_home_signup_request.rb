FactoryGirl.define do
  factory :day_home_signup_request do
    day_home_name 'Day Home 0'
    day_home_slug 'dayhome0'
    day_home_city 'Edmonton'
    day_home_province 'AB'
    day_home_street1 '793 blackburn place'
    day_home_street2 ''
    day_home_postal_code 'T6W1C3'
    day_home_phone_number '780 111 1111'
    day_home_blurb 'The greatest dayhome ever.'

    contact_name 'John Doe'
    contact_phone_number '780 111 1111'
    contact_email 'email@dayhomeregistry.com'
    preferred_time_to_contact 'Morning'

    comments 'I would like to signup ASAP!'
  end
end