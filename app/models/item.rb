class Item < ActiveRecord::Base
	before_create :init_queue
  before_save :set_current_user

  belongs_to :owner, {:class_name => "User"}
  belongs_to :current_user, {:class_name => "User"}
  
  belongs_to :libitem
  
  has_many :trades
  serialize :queue
  
  #TODO Validations
  #TODO Trade-able?  Viewable?

	def destination
		"Person to give back!(find me in item.rb)"
	end
  
  protected

  def set_current_user
    if self.current_user == nil
# This part works.  Set the current user to the owner if no one is the current user
      self.current_user = self.owner
    end
  end
  
  def init_queue
  	self.queue = []
  end

    
end
