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

ActiveRecord::Schema.define(version: 20170120005716) do

  create_table "moves", force: :cascade do |t|
    t.string   "name"
    t.string   "movetype"
    t.string   "category"
    t.integer  "power"
    t.integer  "accuracy"
    t.integer  "levelup_id"
    t.integer  "egg_id"
    t.integer  "tm_id"
    t.integer  "tutor_id"
    t.integer  "evolution_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "pokemons", force: :cascade do |t|
    t.integer  "original_trainer_id"
    t.string   "nickname"
    t.string   "gender"
    t.boolean  "shiny"
    t.string   "nature"
    t.string   "ability"
    t.integer  "HPIV"
    t.integer  "AtkIV"
    t.integer  "DefIV"
    t.integer  "SpAIV"
    t.integer  "SpDIV"
    t.integer  "SpeIV"
    t.string   "hiddenpower"
    t.string   "move1"
    t.string   "move3"
    t.string   "move2"
    t.string   "move4"
    t.string   "ball"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "user_id"
    t.integer  "species_id"
    t.index ["species_id"], name: "index_pokemons_on_species_id"
    t.index ["user_id"], name: "index_pokemons_on_user_id"
  end

  create_table "species", force: :cascade do |t|
    t.string   "name"
    t.string   "form"
    t.integer  "dexno"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "ign"
    t.string   "friend_code"
    t.integer  "trainer_id"
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
