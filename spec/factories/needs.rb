FactoryGirl.define do
  factory :need do
    sequence(:name) {|n| "Need #{n}"}
  end
end
