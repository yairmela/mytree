# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    value "MyString"
    parent "MyString"
  end
end
