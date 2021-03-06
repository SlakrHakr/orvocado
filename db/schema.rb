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

ActiveRecord::Schema.define(version: 20170711030810) do

  create_table "positions", force: :cascade do |t|
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "reasons", force: :cascade do |t|
    t.integer  "position_id",             null: false
    t.integer  "user_id"
    t.string   "description",             null: false
    t.bigint   "score",       default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["position_id"], name: "index_reasons_on_position_id"
    t.index ["user_id"], name: "index_reasons_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.integer  "topic_id",   null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_tags_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string   "description",                   null: false
    t.bigint   "position_one",                  null: false
    t.bigint   "position_two",                  null: false
    t.bigint   "interaction_count", default: 1, null: false
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["user_id"], name: "index_topics_on_user_id"
  end

  create_table "user_positions", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "position_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["position_id"], name: "index_user_positions_on_position_id"
    t.index ["user_id"], name: "index_user_positions_on_user_id"
  end

  create_table "user_reason_agreements", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "reason_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reason_id"], name: "index_user_reason_agreements_on_reason_id"
    t.index ["user_id"], name: "index_user_reason_agreements_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",                            null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
