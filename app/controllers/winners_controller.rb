class WinnersController < ApplicationController
  def index
    @winners = Participation.where(winner: true)
    # @winners = @raffle.participations.where(winner: true).map {|p| p.contestant.name}.flatten

    @raffles = Raffle.all
    @raffle = Raffle.all.order("created_at DESC")
    # @contestants = Contestant.all
  end
end
