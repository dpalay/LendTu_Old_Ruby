class Searchresult < ActiveRecord::Base
	belongs_to :user
	serialize :details
end
