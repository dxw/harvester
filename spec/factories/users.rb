FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@dxw.com" }
    password "password"
  end
end
