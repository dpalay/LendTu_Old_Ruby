class CreateTrades < ActiveRecord::Migration
  def self.up
    create_table :trades do |t|
	    t.integer  "lender_id"
	    t.integer  "borrower_id"
	    t.integer  "item_id"
	    t.boolean  "has_started", :default => false
	    t.boolean  "completed",   :default => false
	    t.string		"status", :default => 'returned'
	    t.string		"location", :default => 'in'
      t.timestamps
    end
    add_column :items, :queue, :text
  end

  def self.down
    drop_table :trades
    remove_column :items, :queue
  end
end
