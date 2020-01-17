# Be sure to restart your server when you modify this file

require 'rubygems'
require '/home/dpalay/.gems/gems/amazon-ecs-0.5.4/lib/amazon/ecs'
#require 'amazon/ecs'
require 'pp'

# Specifies gem version of Rails to use when vendor/rails is not present
 RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

if ENV['RAILS_ENV'] == 'production'  # don't bother on dev
  ENV['GEM_PATH'] = '/home/dpalay/.gems' #+ ':/usr/lib/ruby/gems/1.8'  # Need this or Passenger fails to start
end


Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
  #config.active_record.observers = :user_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
end
Amazon::Ecs.options={:aWS_access_key_id => ['14M06PERRHRKR5DP5202']}



SEARCHTERMS = ["Keywords", "Brand", "Manufacturer", "Title", "Author", "Publisher", "Artist", "Composer", "Conductor", "MusicLabel", "Orchestra", "Actor", "Director", "MPAARating"]
CATEGORIES = {:Apparel => ["Brand", "Keywords", "Manufacturer", "Title"], :Automotive => ["Brand", "Keywords", "Manufacturer", "Title"], :Baby => ["Brand", "Keywords", "Manufacturer", "Title"], :Beauty => ["Brand", "Keywords", "Manufacturer", "Title"], :Blended => ["Keywords"], :Books => ["Author", "Keywords", "Isbn", "Publisher", "Title"], :Classical => ["Artist", "Composer", "Conductor", "Keywords", "MusicLabel", "Orchestra", "Title"], :DigitalMusic => ["Actor", "Director", "Keywords", "MPAARating", "Publisher", "Title"], :DVD => ["Actor", "Director", "Keywords", "MPAARating", "Publisher", "Title"], :Electronics => ["Brand", "Keywords", "Manufacturer", "Title"], :GourmetFood => ["Keywords", "Title"], :HealthPersonalCare => ["Brand", "Manufacturer", "Keywords", "Title"], :Jewelry => ["Keywords", "Title"], :Kitchen => ["Brand", "Manufacturer", "Keywords", "Title"], :Magazines => ["Keywords", "Publisher", "Title"], :Miscellaneous => ["Brand", "Keywords", "Title"], :Music => ["Artist", "Keywords", "MusicLabel", "Title"], :MusicalInstruments => ["Brand", "Manufacturer", "Keywords", "Title"], :OfficeProducts => ["Brand", "Manufacturer", "Keywords", "Title"], :OutdoorLiving => ["Brand", "Manufacturer", "Keywords", "Title"], :PCHardware => ["Brand", "Manufacturer", "Keywords", "Title"], :PetSupplies => ["Keywords", "Title", "Author", "Manufacturer", "Brand", "Condition"], :Photo => ["Brand", "Manufacturer", "Keywords", "Title"], :Software => ["Brand", "Manufacturer", "Keywords", "Title"], :SportingGoods => ["Brand", "Keywords", "Manufacturer", "Title"], :Tools => ["Brand", "Keywords", "Manufacturer", "Title"], :Toys => ["Keywords", "Title"], :VHS => ["Actor", "Director", "Keywords", "MPAARating", "Publisher", "Title"], :Video => ["Actor", "Director", "Keywords", "MPAARating", "Publisher", "Title"], :VideoGames => ["Brand", "Keywords", "Manufacturer", "Title"], :Wireless => ["Keywords", "Title"], :WirelessAccessories => ["Keywords", "Title"]}
SEARCHSORTS = ['relevancerank','salesrank','reviewrank','pricerank','inverse-pricerank','daterank','titlerank','-titlerank','-unit-sales','price','-price','-publication_date']
 
