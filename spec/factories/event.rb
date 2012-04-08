FactoryGirl.define do
  factory :event do
    title 'new_event'
    description 'this is a new event'
    starts_at DateTime.now
    ends_at DateTime.now + 10
    all_day false
  end
end