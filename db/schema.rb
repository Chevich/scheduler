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

ActiveRecord::Schema.define(:version => 20120813091030) do

  create_table "klasses", :force => true do |t|
    t.string   "name"
    t.string   "level"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "klasses", ["name"], :name => "index_klasses_on_name", :unique => true

  create_table "room_subject_relations", :force => true do |t|
    t.integer "room_id"
    t.integer "subject_id"
  end

  add_index "room_subject_relations", ["room_id", "subject_id"], :name => "index_room_subject_relations_on_room_id_and_subject_id", :unique => true
  add_index "room_subject_relations", ["room_id"], :name => "index_room_subject_relations_on_room_id"
  add_index "room_subject_relations", ["subject_id"], :name => "index_room_subject_relations_on_subject_id"

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.string   "number"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "rooms", ["number"], :name => "index_rooms_on_number", :unique => true

  create_table "subjects", :force => true do |t|
    t.string   "name",           :null => false
    t.integer  "level",          :null => false
    t.integer  "hours_per_week", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "subjects", ["name", "level"], :name => "index_subjects_on_name_and_level", :unique => true

  create_table "teachers", :force => true do |t|
    t.string   "fio"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "teachers", ["fio"], :name => "index_teachers_on_fio", :unique => true

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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
