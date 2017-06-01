class AddGameIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :game, index: true
  end
end
