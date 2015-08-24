require 'faker'


FactoryGirl.define do
  factory :participation do
    contestant_id 1
    raffle_id 1
    winner true
  end
end
