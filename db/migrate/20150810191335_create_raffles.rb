class CreateRaffles < ActiveRecord::Migration
  def change
    create_table :raffles do |t|
      t.column :title, :string
      t.column :num_winners, :integer
    end
  end
end
