class CreateWinners < ActiveRecord::Migration
  def change
    create_table :winners do |t|
      t.column :constestant_id, :integer
      t.column :raffle_id, :integer
    end
  end
end
