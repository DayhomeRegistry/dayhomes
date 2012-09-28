FactoryGirl.define do
  sequence :day_home_name do |n| 
    'Day Home #{n}'
  end
  sequence :day_home_slug do |n|
    'dayhome#{n}'
  end
  factory :day_home_signup_request do
    day_home_name
    day_home_slug
    day_home_postal_code 'T6W1C3'    
    day_home_highlight 'the highlight'
    day_home_phone_number '780 111 1111'
    
    #day_home_city 'Edmonton'
    #day_home_province 'AB'
    #day_home_street1 '793 blackburn place'
    #day_home_street2 ''
    #day_home_blurb 'The greatest dayhome ever.'
    #day_home_email 'email@dayhomeregistry.com'
    #plan 'baby'

    #first_name 'John'
    #last_name 'Doe'
    #contact_phone_number '780 111 1111'
    #contact_email 'email@dayhomeregistry.com'
    #preferred_time_to_contact 'Morning'
    #comments 'I would like to signup ASAP!'
    
  end
end