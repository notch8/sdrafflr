class WinnersController < ApplicationController
  def index
    @winners = Participation.where(winner: true)


    @raffles = Raffle.all
    @raffle = Raffle.all.order("created_at DESC")
    @contestants = Contestant.all

  end
end
