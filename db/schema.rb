# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130710210845) do

  create_table "client_cash_plans", :force => true do |t|
    t.integer  "client_id"
    t.string   "expression"
    t.float    "bill_rate"
    t.integer  "bill_minimum"
    t.string   "bridge"
    t.integer  "public_carrier_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "name",              :default => ""
    t.text     "note",              :default => ""
  end

  create_table "client_cashes", :force => true do |t|
    t.integer  "client_id"
    t.float    "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "client_cashes", ["client_id"], :name => "index_client_cashes_on_client_id"

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "sip_user"
    t.string   "sip_pass"
    t.integer  "public_carrier_id"
    t.float    "balance",                :default => 0.0
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "salt",                   :default => ""
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "max_calls",              :default => 1
    t.boolean  "proxy_media",            :default => false
    t.boolean  "bypass_media",           :default => false
  end

  create_table "consumers_request_cashes", :force => true do |t|
    t.integer  "client_id"
    t.float    "amount"
    t.text     "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "freeswitches", :force => true do |t|
    t.string   "name"
    t.string   "ip"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "freeswitches", ["ip"], :name => "index_freeswitches_on_ip"

  create_table "public_carriers", :force => true do |t|
    t.string   "name"
    t.string   "sip_user"
    t.string   "sip_pass"
    t.boolean  "authenticate"
    t.string   "ip"
    t.integer  "port"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "freeswitch_id"
  end

  add_index "public_carriers", ["freeswitch_id"], :name => "index_public_carriers_on_freeswitch_id"

  create_table "public_cash_plans", :force => true do |t|
    t.integer  "public_carrier_id"
    t.string   "expression"
    t.float    "bill_rate"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "bill_minimum",      :default => 0
    t.string   "bridge",            :default => ""
    t.string   "name",              :default => ""
    t.text     "note",              :default => ""
  end

  add_index "public_cash_plans", ["public_carrier_id"], :name => "index_public_cash_plans_on_public_carrier_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
