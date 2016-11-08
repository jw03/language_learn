class AddCoinToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :total_coins, :integer, :default => 0
  end
end
