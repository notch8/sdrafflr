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
      redirect_to raffle_path(@raffle)
    else
      flash[:notice] = "Oops, something went wrong!"
      render 'new'
    end
  end

  def show
    @raffle = Raffle.find(params[:id])
    @contestants = Contestant.where(raffle_id: @raffle.id)
    binding.pry

  end

  private
    def raffle_params
       params.require(:raffle).permit(:title, :num_winners, :contestant_names)
    end
end
