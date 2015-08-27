class Contestant < ActiveRecord::Base
  validates :name, presence: true

  has_many :participations
  has_many :raffles, through: :participations

  def name=(value)
    super(value.strip)
  end

end
