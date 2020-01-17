class CreateSearchresult < ActiveRecord::Migration
  def self.up
  create_table :searchresults do |t|
      t.integer :user_id
      t.text :details

      t.timestamps
    end
  end

  def self.down
    drop_table :searchresults
  end
end
