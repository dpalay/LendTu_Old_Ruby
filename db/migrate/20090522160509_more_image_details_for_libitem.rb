class MoreImageDetailsForLibitem < ActiveRecord::Migration
  def self.up
  	add_column :libitems, :small_height, :string
  	add_column :libitems, :medium_height, :string
  	add_column :libitems, :swatch_height, :string
  	add_column :libitems, :large_height, :string
  	add_column :libitems, :small_width, :string
  	add_column :libitems, :medium_width, :string
  	add_column :libitems, :swatch_width, :string
  	add_column :libitems, :large_width, :string
  	add_column :libitems, :swatch_image, :string
  end

  def self.down
  	remove_column :libitems, :small_height
  	remove_column :libitems, :medium_height
  	remove_column :libitems, :swatch_height
  	remove_column :libitems, :large_height
  	remove_column :libitems, :small_width
  	remove_column :libitems, :medium_width
  	remove_column :libitems, :swatch_width
  	remove_column :libitems, :large_width
  	remove_column :libitems, :swatch_image
  end
end
