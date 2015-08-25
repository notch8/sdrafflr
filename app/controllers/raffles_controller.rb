class RafflesController < ApplicationController
  def index
    @raffle = Raffle.new
  end

  def edit
    @raffle = Raffle.find(params[:id])
    @participations = Participation.where(raffle_id: @raffle.id)
    respond_to do |format|
      format.html
      format.json { render json: @participations.map {|p| p.contestant.name } }
    end
  end

  def create
    @raffle = Raffle.new(raffle_params)
    if @raffle.save
      redirect_to edit_raffle_path(@raffle)
    else
      flash[:notice] = "Oops, something went wrong!"
      render 'index'
    end
  end

  def update
    @raffle = Raffle.find(params[:id])
    if @raffle.update_attributes(raffle_params)
      @raffle.pick_winners
      redirect_to raffle_path(@raffle)
    else
      flash[:notice] = "Oops, something went wrong!"
      render 'new'
    end
  end

  def show
    @raffle = Raffle.find(params[:id])
    @winners = @raffle.participations.where(winner: true).map {|p| p.contestant.name}.flatten
  end

  def old
    @raffles = Raffle.all
  end

  def get_participants
    @participations = Participation.where(raffle_id: @raffle.id)
  end

  private
    def raffle_params
       params.require(:raffle).permit(:title, :num_winners, :contestant_names)
    end

end
