FactoryGirl.define do
  factory :day_home_photo do
    day_home
    photo { File.open(File.join(Rails.root, 'spec', 'support', 'test_image.png')) }
  end
end