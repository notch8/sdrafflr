require 'faker'


FactoryGirl.define do
  factory :raffle do |f|
    f.title { Faker::App.name }
    f.num_winners { Faker::Number.between(1, 3) }
  end
end
