class AddTimeStampsToRaffles < ActiveRecord::Migration
  def change
    add_column :raffles, :created_at, :timestamp
    add_column :contestants, :created_at, :timestamp
  end
end
