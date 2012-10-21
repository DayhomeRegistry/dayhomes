FactoryGirl.define do
  sequence(:email) {|n| "user#{n}@doe.com"}
  sequence(:perishable_token) {|n| Digest::MD5.hexdigest("#{Time.now}-user#{n}@doe.com")}
  sequence(:single_access_token) {|n| Digest::MD5.hexdigest("#{Time.now}-user#{n}@doe.com")}
  sequence(:persistence_token) {|n| Digest::MD5.hexdigest("#{Time.now}-user#{n}@doe.com")}
      
  factory :user do
    email
    first_name 'John'
    last_name 'Doe'
    password 'john4doe'
    password_confirmation 'john4doe'
    crypted_password "c4cd6c8b9b3791090fdc5422f47d242dda2735d31"
    password_salt "c4cd6c8b9b3791090fdc5422f47d242dda2735d31"
    persistence_token 
    single_access_token 
    perishable_token 
    login_count 1
    failed_login_count 1
    last_request_at "Tue Feb 02 20:35:46 -0600 2010"
    current_login_at "Tue Feb 02 20:35:46 -0600 2010"
    last_login_at "Tue Feb 02 20:35:46 -0600 2010"
    current_login_ip "127.0.0.1"
    last_login_ip "127.0.0.1"
    facebook_access_token "AAAD7xLVpVzMBAE5qrxBoG2VhcY5MCE17JTMs8X5N27A4cfE3ZCiGZAeLOzCsdsiMI1DzTP2W3rwZAhvkpQMwffzNbXzNSZBZBO7oml6uX9AZDZD"
    facebook_access_token_expires_in "5183999"    
  end
  factory :anotheruser do
    email 'jane@doe.com'
    first_name 'Jane'
    last_name 'Doe'
    password 'john4doe'
    password_confirmation 'john4doe'
    crypted_password "c4cd6c8b9b3791090fdc5422f47d242dda2735d31"
    password_salt "c4cd6c8b9b3791090fdc5422f47d242dda2735d31"
    persistence_token "c4cd6c8b9b3791090fdc5422f47d242dda2735d31"
    single_access_token "c4cd6c8b9b3791090fdc5422f47d242dda2735d31"
    perishable_token "c4cd6c8b9b3791090fdc5422f47d242dda2735d31"
    login_count 1
    failed_login_count 1
    last_request_at "Tue Feb 02 20:35:46 -0600 2010"
    current_login_at "Tue Feb 02 20:35:46 -0600 2010"
    last_login_at "Tue Feb 02 20:35:46 -0600 2010"
    current_login_ip "127.0.0.1"
    last_login_ip "127.0.0.1"
  end
end