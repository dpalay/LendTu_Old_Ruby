class UpdatesToItemAndLibitem < ActiveRecord::Migration
  def self.up
  	add_column :items, :tradeable, :integer
  	add_column :libitems, :isbn, :string
  end

  def self.down
  	remove_column :items, :tradeable
  	remove_column :libitems, :isbn
  end
end
