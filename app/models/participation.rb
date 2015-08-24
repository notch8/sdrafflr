class Participation < ActiveRecord::Base
  belongs_to :contestant
  belongs_to :raffle

  accepts_nested_attributes_for :raffle
  accepts_nested_attributes_for :contestant

  # validates :raffle_id, presence: true, uniqueness: true
  # validates :contestant_id, presence: true, uniqueness: true
  # validates :winner, :inclusion => {:in => [true, false]}
end
