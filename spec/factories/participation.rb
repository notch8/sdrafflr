require 'faker'


FactoryGirl.define do
  factory :participation do |f|
    f.contestant_id 1
    f.raffle_id 1
    f.winner true
  end
end
