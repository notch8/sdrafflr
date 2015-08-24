require 'faker'


FactoryGirl.define do
  factory :raffle do
    title { Faker::App.name }
    num_winners { [1,2,3,4,5].sample }
  end
end
