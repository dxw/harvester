FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@dxw.com" }
    sequence(:password) { |m| "P@55w0rd#{m}" }
  end
end
