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

ActiveRecord::Schema.define(:version => 20120914145741) do

  create_table "klass_subject_relations", :force => true do |t|
    t.integer "klass_id",       :null => false
    t.integer "subject_id",     :null => false
    t.integer "hours_per_week", :null => false
  end

  add_index "klass_subject_relations", ["klass_id", "subject_id"], :name => "index_klass_subject_relations_on_klass_id_and_subject_id", :unique => true
  add_index "klass_subject_relations", ["klass_id"], :name => "index_klass_subject_relations_on_klass_id"
  add_index "klass_subject_relations", ["subject_id"], :name => "index_klass_subject_relations_on_subject_id"

  create_table "klasses", :force => true do |t|
    t.integer  "user_id",         :null => false
    t.string   "name",            :null => false
    t.integer  "level",           :null => false
    t.integer  "lessons_per_day", :null => false
    t.integer  "days_per_week",   :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "klasses", ["user_id", "name"], :name => "index_klasses_on_user_id_and_name", :unique => true

  create_table "rooms", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "name",       :null => false
    t.string   "number",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "rooms", ["user_id", "number"], :name => "index_rooms_on_user_id_and_number", :unique => true

  create_table "settings", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "name",       :null => false
    t.string   "value",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subject_room_relations", :force => true do |t|
    t.integer "subject_id", :null => false
    t.integer "room_id",    :null => false
  end

  add_index "subject_room_relations", ["room_id"], :name => "index_subject_room_relations_on_room_id"
  add_index "subject_room_relations", ["subject_id", "room_id"], :name => "index_subject_room_relations_on_subject_id_and_room_id", :unique => true
  add_index "subject_room_relations", ["subject_id"], :name => "index_subject_room_relations_on_subject_id"

  create_table "subjects", :force => true do |t|
    t.integer  "user_id",        :null => false
    t.string   "name",           :null => false
    t.integer  "level",          :null => false
    t.integer  "hours_per_week"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "subjects", ["user_id", "name", "level"], :name => "index_subjects_on_user_id_and_name_and_level", :unique => true

  create_table "teacher_klass_subject_relations", :force => true do |t|
    t.integer "teacher_id", :null => false
    t.integer "klass_id",   :null => false
    t.integer "subject_id", :null => false
  end

  add_index "teacher_klass_subject_relations", ["klass_id"], :name => "index_teacher_klass_subject_relations_on_klass_id"
  add_index "teacher_klass_subject_relations", ["teacher_id", "klass_id", "subject_id"], :name => "by_klass", :unique => true
  add_index "teacher_klass_subject_relations", ["teacher_id"], :name => "index_teacher_klass_subject_relations_on_teacher_id"

  create_table "teacher_room_relations", :force => true do |t|
    t.integer "teacher_id", :null => false
    t.integer "room_id",    :null => false
  end

  add_index "teacher_room_relations", ["room_id"], :name => "index_teacher_room_relations_on_room_id"
  add_index "teacher_room_relations", ["teacher_id", "room_id"], :name => "index_teacher_room_relations_on_teacher_id_and_room_id", :unique => true
  add_index "teacher_room_relations", ["teacher_id"], :name => "index_teacher_room_relations_on_teacher_id"

  create_table "teacher_subject_relations", :force => true do |t|
    t.integer "teacher_id", :null => false
    t.integer "subject_id", :null => false
  end

  add_index "teacher_subject_relations", ["subject_id"], :name => "index_teacher_subject_relations_on_subject_id"
  add_index "teacher_subject_relations", ["teacher_id", "subject_id"], :name => "index_teacher_subject_relations_on_teacher_id_and_subject_id", :unique => true
  add_index "teacher_subject_relations", ["teacher_id"], :name => "index_teacher_subject_relations_on_teacher_id"

  create_table "teachers", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "fio",        :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "teachers", ["user_id", "fio"], :name => "index_teachers_on_user_id_and_fio", :unique => true

  create_table "timetables", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "version",    :null => false
    t.string   "comment",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "timetables_dtls", :force => true do |t|
    t.integer "timetable_id", :null => false
    t.integer "day",          :null => false
    t.integer "lesson",       :null => false
    t.integer "klass_id",     :null => false
    t.integer "subject_id",   :null => false
    t.integer "teacher_id",   :null => false
    t.integer "room_id",      :null => false
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
