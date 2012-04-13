# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    day_home_id nil
    user nil
    content ''
    rating 0
  end
end
