class Raffle < ActiveRecord::Base
  validates :title, presence: true
  validates :num_winners, presence: true
  validates_numericality_of :num_winners, :only_integer => true, :greater_than => 0

  has_many :participations
  has_many :contestants, through: :participations
  accepts_nested_attributes_for :participations
  accepts_nested_attributes_for :contestants

  validate do |raffle|
    raffle.errors.add(:num_winners, "must be less than number of participants") if raffle.num_winners.to_i > 0 and raffle.contestants.size <= raffle.num_winners.to_i
  end

  validate do |raffle|
    raffle.errors.add(:contestants, "must not contain duplicate entries") if raffle.contestants.collect { |contestant| contestant.name }.uniq.size < raffle.contestants.size
  end


  # Takes a string of contestant names, one per line, makes associations
  #"Rob\nAllie\nEthan"
  def contestant_names=(value)
    names = value.split("\n").map {|item| item.strip}
    names.each do |name|
      c = Contestant.find_or_initialize_by(name: name)
      self.contestants << c
    end
  end

  def contestant_names
    self.contestants.map(&:name).join("\n")
  end
end
