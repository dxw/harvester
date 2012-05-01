FactoryGirl.define do
  factory :page do
    name 'dxw'
    uri 'http://dxw.com/'

    factory :page_with_attributes do
      attrs [FactoryGirl.create(:attr)]
    end
  end
end
