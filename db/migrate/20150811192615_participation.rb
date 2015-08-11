class Participation < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.column :contestant_id, :integer
      t.column :raffle_id, :integer
      t.column :winner, :boolean
      t.timestamps
    end
  end
end
