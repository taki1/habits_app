# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :habit do
    user_id 1
    target "MyString"
    start_at "2015-01-16 12:41:05"
    end_at "2015-01-16 12:41:05"
  end
end
