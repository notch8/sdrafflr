class AddFromToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :from, :string
  end
end
