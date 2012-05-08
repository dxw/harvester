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

ActiveRecord::Schema.define(:version => 20120508104739) do

  create_table "attrs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "attrs", ["id"], :name => "index_attrs_on_id"

  create_table "audiences", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "audiences", ["id"], :name => "index_audiences_on_id"

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "departments", ["id"], :name => "index_departments_on_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "taken_by"
    t.integer  "department_id"
  end

  add_index "groups", ["id"], :name => "index_groups_on_id"

  create_table "needs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "taken_by"
  end

  add_index "needs", ["id"], :name => "index_needs_on_id"

  create_table "new_pages", :force => true do |t|
    t.integer  "page_id"
    t.string   "uri"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "new_pages", ["id"], :name => "index_new_pages_on_id"

  create_table "pages", :force => true do |t|
    t.string   "uri"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "group_id"
  end

  add_index "pages", ["id"], :name => "index_pages_on_id"

  create_table "pages_attributes", :id => false, :force => true do |t|
    t.integer "page_id"
    t.integer "attr_id"
  end

  add_index "pages_attributes", ["attr_id"], :name => "index_pages_attributes_on_attr_id"
  add_index "pages_attributes", ["page_id"], :name => "index_pages_attributes_on_page_id"

  create_table "pages_audiences", :id => false, :force => true do |t|
    t.integer "page_id"
    t.integer "audience_id"
  end

  add_index "pages_audiences", ["audience_id"], :name => "index_pages_audiences_on_audience_id"
  add_index "pages_audiences", ["page_id"], :name => "index_pages_audiences_on_page_id"

  create_table "pages_needs", :id => false, :force => true do |t|
    t.integer "page_id"
    t.integer "need_id"
  end

  add_index "pages_needs", ["need_id"], :name => "index_pages_needs_on_need_id"
  add_index "pages_needs", ["page_id"], :name => "index_pages_needs_on_page_id"

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
  add_index "users", ["id"], :name => "index_users_on_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_departments", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "department_id"
  end

  add_index "users_departments", ["department_id"], :name => "index_users_departments_on_department_id"
  add_index "users_departments", ["user_id"], :name => "index_users_departments_on_user_id"

end
