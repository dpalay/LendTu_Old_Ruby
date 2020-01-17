class AddMyRequestsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :my_requests, :text
  end

  def self.down
    remove_column :users, :my_requests
  end
end
