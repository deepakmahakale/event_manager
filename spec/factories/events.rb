FactoryBot.define do
  factory :event do
    title { 'MyString' }
    start_time { Date.today }
    end_time { Date.tomorrow }
    description { 'MyText' }
    all_day { false }
  end
end
