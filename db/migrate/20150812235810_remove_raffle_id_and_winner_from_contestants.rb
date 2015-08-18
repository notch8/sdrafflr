class RemoveRaffleIdAndWinnerFromContestants < ActiveRecord::Migration
  def change
    remove_column :contestants, :raffle_id
    remove_column :contestants, :winner


  end
end
