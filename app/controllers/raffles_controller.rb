require "pry"
class RafflesController < ApplicationController
  def index
    @raffles = Raffle.all
  end

  def new
    @raffle = Raffle.new
  end

  def create
    @raffle = Raffle.new(raffle_params)
    if @raffle.save
      render 'show'
    else
      flash[:notice] = "Oops, something went wrong!"
      render 'new'
    end
    @contestants = params[:contestants]
    contestants = @contestants.split(/\W+/)
    contestants.each {|c| @raffle.contestants << Contestant.new(:name => c, :raffle_id => @raffle.id)}
  end

  def show
    @raffle = Raffle.find(params[:id])
  end

  private
    def raffle_params
       params.require(:raffle).permit(:title, :num_winners)
    end
end
