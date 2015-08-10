class Winner < ActiveRecord::Base
  validates :raffle_id, presence: true
  validates :contestant_id, presence: true

  belongs_to :raffle
  has_many :contestants
end
