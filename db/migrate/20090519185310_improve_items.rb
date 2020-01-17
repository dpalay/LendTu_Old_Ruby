class ImproveItems < ActiveRecord::Migration
  def self.up
  	add_column :items, :Actor, :string
  	add_column :items, :Brand, :string
  	add_column :items, :City, :string
  	add_column :items, :Composer, :string
  	add_column :items, :Condition, :string
  	add_column :items, :Conductor, :string
  	add_column :items, :Cuisine, :string
  	add_column :items, :Director, :string
  	add_column :items, :Manufacturer, :string
  	add_column :items, :MPAARating, :string
  	add_column :items, :MusicLabel, :string
  	add_column :items, :Orchestra, :string
  	add_column :items, :Publisher, :string
  	add_column :items, :Asin, :string
  	
  end

  def self.down
  	remove_column :items, :Actor
  	remove_column :items, :Brand
  	remove_column :items, :City
  	remove_column :items, :Composer
  	remove_column :items, :Condition
  	remove_column :items, :Conductor
  	remove_column :items, :Cuisine
  	remove_column :items, :Director
  	remove_column :items, :Manufacturer
  	remove_column :items, :MPAARating
  	remove_column :items, :MusicLabel
  	remove_column :items, :Orchestra
  	remove_column :items, :Publisher
  	remove_column :items, :Asin
  end
end
