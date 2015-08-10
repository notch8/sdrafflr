class CreateContestants < ActiveRecord::Migration
  def change
    create_table :contestants do |t|
      t.column :name, :string
      t.column :raffle_id, :integer
    end
  end
end
