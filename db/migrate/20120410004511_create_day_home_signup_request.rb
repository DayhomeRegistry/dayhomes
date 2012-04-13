class CreateDayHomeSignupRequest < ActiveRecord::Migration
  def change
    create_table :day_home_signup_requests do |t|
      t.string :day_home_name
      t.string :day_home_slug
      t.string :day_home_city
      t.string :day_home_province
      t.string :day_home_street1
      t.string :day_home_street2
      t.string :day_home_postal_code
      t.string :day_home_phone_number
      t.text :day_home_blurb
      
      t.string :contact_name
      t.string :contact_phone_number
      t.string :contact_email
      t.string :preferred_time_to_contact
      
      t.text :comments
      t.timestamps
    end
  end
end
