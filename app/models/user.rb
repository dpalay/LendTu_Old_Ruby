require 'digest/sha1'

class User < ActiveRecord::Base
	
	before_create :init_my_requests
	
	has_many :results, {:class_name => "Searchresult", :order => "created_at DESC"}

  has_many :owned_items, {:class_name => "Item", :foreign_key => "owner_id"}
  has_many :current_items, {:class_name => "Item", :foreign_key => "current_user_id"}

	has_many :lends, :class_name => "Trade", :foreign_key => "lender_id"
	has_many :borrows, :class_name => "Trade", :foreign_key => "borrower_id"
	
	#items a person has borrowed and needs to return
	has_many :outgoing_lends,	:through => :lends, :conditions => "status = 'outgoing'", :source => :item
	#items a person 
	has_many :returning_borrows,	:through => :borrows, :conditions => "status = 'incoming'", :source => :item
	
	#items a person has lent out and is getting back
	has_many :incoming_lends,		:through => :lends, :conditions => "status = 'incoming'", :source => :item
	#items a person is borrowing and is about to get
	has_many :outgoing_borrows,	:through => :borrows, :conditions => "status = 'outgoing'", :source => :item 
	
	#items a person is borrowing and is in possession of
	has_many :recieved_borrows,	:through => :borrows, :conditions => "status = 'recieved'", :source => :item
	
	#Items a person has given out, and the other person has.
	has_many :recieved_lends,		:through => :lends, :conditions => "status = 'recieved'", :source => :item
	
  has_many :friendships
  
  has_many :friends, :through => :friendships, :conditions => "status = 'accepted'", :order => :login
  has_many :requested_friends, :through => :friendships, :conditions => "status = 'requested'", :order => "friendships.created_at", :source => :friend
  has_many :pending_friends, :through => :friendships, :conditions => "status = 'pending'", :order => "friendships.created_at", :source => :friend

	has_one :spec 
  
  serialize :my_requests
  
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  #validates_format_of       :screen_name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  #validates_length_of       :screen_name,     :within => 5..15

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  before_create :make_activation_code 

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation


  # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find :first, :conditions => ['login = ? and activated_at IS NOT NULL', login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  
  def avatar
  	Avatar.new(self)
  end
  


  protected
    
    def make_activation_code
        self.activation_code = self.class.make_token
    end
    
  def init_my_requests
  	self.my_requests = []
  end



end
