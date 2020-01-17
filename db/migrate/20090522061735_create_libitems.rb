class CreateLibitems < ActiveRecord::Migration
  def self.up
    create_table :libitems do |t|
	  t.string :actor
	  t.string :brand
	  t.string :city
	  t.string :composer
	  t.string :condition
	  t.string :conductor
	  t.string :cuisine
	  t.string :director
	  t.string :manufacturer
	  t.string :mpaarating
	  t.string :musiclabel
	  t.string :orchestra
	  t.string :publisher
	  t.string :asin
	  t.string :author
	  t.string :title
	  t.text :details
	  t.string :large_image
	  t.string :medium_image
	  t.string :small_image
      t.timestamps
    end
    
    add_column :items, :libitem_id, :integer
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
  	remove_column :items, :Author
  	remove_column :items, :title
  	remove_column :items, :details
  end

  def self.down
    drop_table :libitems
    
    remove_column :items, :libitem_id
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
  	add_column :items, :Author, :string
  	add_column :items, :title, :string
  	add_column :items, :details, :text
  end
end
