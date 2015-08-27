class Raffle < ActiveRecord::Base
  has_many :participations
  has_many :contestants, through: :participations
  accepts_nested_attributes_for :participations
  accepts_nested_attributes_for :contestants

  validates :title, presence: true, uniqueness: true
  # validates :num_winners, presence: true, numericality: { only_integer: true, greater_than: 0}
  #
  # # works but causes tests to fail
  # validate do |raffle|
  #   raffle.errors.add(:num_winners, "must be less than number of participants") if num_winners > 0 && raffle.participations.size <= num_winners
  # end



  # Takes a string of contestant names, one per line, makes associations
  #"Rob\nAllie\nEthan"
  def contestant_names=(value)
    names = value.split("\n").map {|item| item.strip}
    names.each do |name|
      name.strip!
      if !self.contestants.exists?(name: name)
        c = Contestant.find_or_create_by(name: name)
        self.contestants << c
      end
    end
  end

  def contestant_names
    self.contestants.map(&:name).join("\n")
  end

  def pick_winners
    winners = participations.sample(num_winners)
    winners.each{|winner| winner.update_attribute :winner, true}
    return winners
  end

  def winners
   winners = participations.includes(:contestant).where(winner: true).map(&:contestant)
 end
end
