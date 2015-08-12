class Raffle < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :num_winners, presence: true

  has_many :participations
  has_many :contestants, through: :participations
  accepts_nested_attributes_for :participations
  accepts_nested_attributes_for :contestants

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
