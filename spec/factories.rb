FactoryGirl.define do
  factory :city do
    sequence(:name) { |n| "My name #{n}" }
    sequence(:description) { |n| "My description #{n}" }
  end
end