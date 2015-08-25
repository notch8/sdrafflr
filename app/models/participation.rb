class Participation < ActiveRecord::Base
  belongs_to :contestant
  belongs_to :raffle

  accepts_nested_attributes_for :raffle
  accepts_nested_attributes_for :contestant


  validates_uniqueness_of :contestant_id, scope: :raffle_id
  validates_uniqueness_of :from, scope: :raffle_id, :allow_blank => true, :allow_nil => true


  # validates :raffle_id, presence: true, uniqueness: true
  # validates :contestant_id, presence: true, uniqueness: true
  # validates :winner, :inclusion => {:in => [true, false]}
end
