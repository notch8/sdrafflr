class Winner < ActiveRecord::Base


has_many :participations
has_many :contestants
has_many :raffles


end
