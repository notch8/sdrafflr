require 'faker'


FactoryGirl.define do
  factory :contestant do |f|
    f.name { Faker::Name.name }
  end
end
