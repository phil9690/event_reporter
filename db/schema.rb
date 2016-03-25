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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160325141241) do

  create_table "employees", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "active",     limit: 1,   default: true
    t.integer  "pid",        limit: 4
    t.boolean  "trainee",    limit: 1
  end

  create_table "events", force: :cascade do |t|
    t.string   "incident_type", limit: 255
    t.text     "description",   limit: 65535
    t.integer  "employee_id",   limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "user_id",       limit: 4
  end

  add_index "events", ["employee_id"], name: "index_events_on_employee_id", using: :btree

  create_table "job_types", force: :cascade do |t|
    t.string   "job_type",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.integer  "job_number",  limit: 4
    t.string   "job_name",    limit: 255
    t.integer  "job_type_id", limit: 4
    t.float    "bonus_rate",  limit: 24
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "jobs", ["job_type_id"], name: "index_jobs_on_job_type_id", using: :btree

  create_table "read_marks", force: :cascade do |t|
    t.integer  "readable_id",   limit: 4
    t.string   "readable_type", limit: 255, null: false
    t.integer  "user_id",       limit: 4,   null: false
    t.datetime "timestamp"
  end

  add_index "read_marks", ["user_id", "readable_type", "readable_id"], name: "index_read_marks_on_user_id_and_readable_type_and_readable_id", using: :btree

  create_table "scores", force: :cascade do |t|
    t.integer  "employee_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.integer  "job_id",      limit: 4
    t.float    "score",       limit: 24
    t.integer  "completes",   limit: 4
    t.float    "hours",       limit: 24
    t.date     "score_date"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "scores", ["employee_id"], name: "index_scores_on_employee_id", using: :btree
  add_index "scores", ["job_id"], name: "index_scores_on_job_id", using: :btree
  add_index "scores", ["user_id"], name: "index_scores_on_user_id", using: :btree

  create_table "suspensions", force: :cascade do |t|
    t.integer  "employee_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "event_id",    limit: 4
  end

  create_table "unreads", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "event_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "username",        limit: 255
    t.string   "authority",       limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "password_digest", limit: 255
    t.string   "email",           limit: 255
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "events", "employees"
  add_foreign_key "jobs", "job_types"
  add_foreign_key "scores", "employees"
  add_foreign_key "scores", "jobs"
  add_foreign_key "scores", "users"
end
