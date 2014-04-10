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

ActiveRecord::Schema.define(version: 20140409100704) do

  create_table "action_plans_expense_items", force: true do |t|
    t.string  "kind",       limit: 256,             null: false
    t.integer "value",                  default: 0, null: false
    t.integer "frequency",                          null: false
    t.integer "expense_id",                         null: false
  end

  create_table "action_plans_expenses", force: true do |t|
    t.string  "category", limit: 256,             null: false
    t.integer "total",                default: 0, null: false
    t.integer "plan_id",                          null: false
  end

  create_table "action_plans_redundancy_contractual_packages", force: true do |t|
    t.integer  "amount"
    t.integer  "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "salary_units"
    t.string   "salary_period"
    t.integer  "duration_units"
    t.string   "duration_period"
  end

  create_table "action_plans_redundancy_insurances", force: true do |t|
    t.boolean  "ack_mortgage"
    t.boolean  "ack_payment"
    t.boolean  "ack_unemployment"
    t.integer  "plan_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "action_plans_redundancy_plans", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_task_id"
    t.integer  "step_number"
    t.integer  "total_steps"
  end

  create_table "action_plans_redundancy_rights", force: true do |t|
    t.string  "code",         limit: 256,                 null: false
    t.boolean "acknowledged",             default: false, null: false
    t.integer "plan_id",                                  null: false
  end

  create_table "action_plans_redundancy_stories", force: true do |t|
    t.integer  "plan_id",             null: false
    t.date     "redundant_at"
    t.date     "started_at"
    t.date     "date_of_birth"
    t.integer  "salary"
    t.integer  "salary_period"
    t.integer  "know_company_status"
    t.integer  "company_status"
    t.integer  "redundant_employees"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "action_plans_redundancy_tasks", force: true do |t|
    t.string   "code",       limit: 256,                 null: false
    t.boolean  "completed",              default: false, null: false
    t.integer  "plan_id",                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
