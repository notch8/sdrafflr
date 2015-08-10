class Raffle < ActiveRecord::Base
  validates :name, presence: true
  validates :num_winners, presence: true

  has_many :contestants
  has_many :winners
end
