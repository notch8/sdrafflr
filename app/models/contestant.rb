class Contestant < ActiveRecord::Base
  validates :name, presence: true
  validates :raffle_id, presence: true

  belongs_to :raffle
  has_many :winners
end
