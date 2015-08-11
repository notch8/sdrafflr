class Raffle < ActiveRecord::Base
  validates :title, presence: true
  validates :num_winners, presence: true

  has_many :contestants
  accepts_nested_attributes_for :contestants
end
