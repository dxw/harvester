FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@dxw.com" }
    sequence(:password) { |m| "password#{m}" }
  end
end
