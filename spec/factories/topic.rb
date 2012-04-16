FactoryGirl.define do
  factory :topic do
    title '(Sticky) Items that should be banned?'
    sticky true
    locked false
    body 'Does anyone have a list of banned items for parents?'
  end
end