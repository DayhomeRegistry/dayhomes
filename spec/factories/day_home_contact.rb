FactoryGirl.define do
  factory :day_home_contact do
    day_home_email 'john@dayhome.com'
    name 'John Doe'
    email 'john@doe.com'
    phone '403 111 1111'
    subject 'Question?'
    message 'How long have you guys been around for?'
    association :day_home_id, factory: :day_home, stragegy: :create!
    f.after_build { |foo|
      foo.bars << Factory.build(:bar, :foo => foo)
    }
    f.after_create { |foo|
      foo.bars.each { |bar| bar.save! }
    }
  end
end