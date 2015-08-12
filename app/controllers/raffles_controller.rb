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

    @winners = @raffle.contestants.sample(@raffle.num_winners)
    # @participations = @raffle.participations
    @winners.each do |winner|
      winner.raffles << @raffle
      @participation = winner.participations.where(raffle_id: @raffle.id).first
      @participation.update_attributes(winner: true)
      # @participations.each do |participation|
      #   if participation.contestant_id == winner.id
      #     participation.winner = true
      #   else
      #     participation.winner = false
      #   end
      #   participation.save
      # end
    end
    binding.pry

  end

  private
    def raffle_params
       params.require(:raffle).permit(:title, :num_winners, :contestant_names)
    end
end
