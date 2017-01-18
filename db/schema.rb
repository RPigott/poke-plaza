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

ActiveRecord::Schema.define(version: 20170118004818) do

  create_table "pokemons", force: :cascade do |t|
    t.integer  "trainer_id"
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
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "species_id"
    t.index ["species_id"], name: "index_pokemons_on_species_id"
    t.index ["user_id"], name: "index_pokemons_on_user_id"
  end

  create_table "species", force: :cascade do |t|
    t.string   "name"
    t.integer  "dexno"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "ign"
    t.integer  "friend_code"
    t.integer  "trainer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
