class Participation < ActiveRecord::Base
  belongs_to :contestant
  belongs_to :raffle

  accepts_nested_attributes_for :raffle
  accepts_nested_attributes_for :contestant
end
