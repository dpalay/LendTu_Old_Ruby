# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090610192548) do

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "accepted_at"
    t.string   "status"
  end

  create_table "items", :force => true do |t|
    t.integer  "owner_id"
    t.integer  "current_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "libitem_id"
    t.integer  "tradeable"
  end

  create_table "libitems", :force => true do |t|
    t.string   "actor"
    t.string   "brand"
    t.string   "city"
    t.string   "composer"
    t.string   "condition"
    t.string   "conductor"
    t.string   "cuisine"
    t.string   "director"
    t.string   "manufacturer"
    t.string   "mpaarating"
    t.string   "musiclabel"
    t.string   "orchestra"
    t.string   "publisher"
    t.string   "asin"
    t.string   "author"
    t.string   "title"
    t.text     "details"
    t.string   "large_image"
    t.string   "medium_image"
    t.string   "small_image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "small_height"
    t.string   "medium_height"
    t.string   "swatch_height"
    t.string   "large_height"
    t.string   "small_width"
    t.string   "medium_width"
    t.string   "swatch_width"
    t.string   "large_width"
    t.string   "swatch_image"
    t.string   "isbn"
    t.string   "console"
  end

  create_table "spec", :force => true do |t|
    t.string   "user_id"
    t.string   "firstname",  :limit => 100, :default => ""
    t.string   "lastname",   :limit => 100, :default => ""
    t.datetime "birthdate"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.string   "aim"
    t.string   "msn"
    t.string   "yahoo"
    t.string   "ICQ"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "specs", :force => true do |t|
    t.integer  "user_id"
    t.string   "firstname",  :limit => 100, :default => ""
    t.string   "lastname",   :limit => 100, :default => ""
    t.datetime "birthdate"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.string   "aim"
    t.string   "msn"
    t.string   "yahoo"
    t.string   "ICQ"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "role",                                     :default => "basic"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
