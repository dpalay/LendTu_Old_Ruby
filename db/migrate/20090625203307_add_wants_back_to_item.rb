class AddWantsBackToItem < ActiveRecord::Migration
  def self.up
  	add_column :items, :wants_back, :boolean
  end

  def self.down
  	remove_column :items, :wants_back
  end
end
