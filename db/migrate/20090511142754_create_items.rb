class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.integer :owner_id
      t.integer :current_user_id
      t.string :title
      t.text :details

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
