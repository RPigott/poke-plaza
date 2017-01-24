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

ActiveRecord::Schema.define(version: 20170123232937) do

  create_table "abilities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "egg_groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "egg_moves", id: false, force: :cascade do |t|
    t.integer "species_id"
    t.integer "move_id"
    t.index ["move_id"], name: "index_egg_moves_on_move_id"
    t.index ["species_id"], name: "index_egg_moves_on_species_id"
  end

  create_table "evolution_moves", id: false, force: :cascade do |t|
    t.integer "species_id"
    t.integer "move_id"
    t.index ["move_id"], name: "index_evolution_moves_on_move_id"
    t.index ["species_id"], name: "index_evolution_moves_on_species_id"
  end

  create_table "immunities", id: false, force: :cascade do |t|
    t.integer "attacker_id"
    t.integer "defender_id"
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "spritename"
    t.string   "group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "levelup_moves", id: false, force: :cascade do |t|
    t.integer "species_id"
    t.integer "move_id"
    t.index ["move_id"], name: "index_levelup_moves_on_move_id"
    t.index ["species_id"], name: "index_levelup_moves_on_species_id"
  end

  create_table "moves", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.integer  "power"
    t.integer  "accuracy"
    t.integer  "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type_id"], name: "index_moves_on_type_id"
  end

  create_table "natures", force: :cascade do |t|
    t.string   "name"
    t.string   "positive"
    t.string   "negative"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.text     "body"
    t.integer  "poster_id"
    t.integer  "postee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offered", id: false, force: :cascade do |t|
    t.integer "trade_id"
    t.integer "offered_id"
  end

  create_table "pokemons", force: :cascade do |t|
    t.integer  "original_trainer_id"
    t.string   "nickname"
    t.integer  "level"
    t.integer  "gender"
    t.boolean  "shiny"
    t.string   "ability"
    t.integer  "HPIV"
    t.integer  "AtkIV"
    t.integer  "DefIV"
    t.integer  "SpAIV"
    t.integer  "SpDIV"
    t.integer  "SpeIV"
    t.integer  "hiddenpower_id"
    t.integer  "move1_id"
    t.integer  "move3_id"
    t.integer  "move2_id"
    t.integer  "move4_id"
    t.integer  "ball_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "user_id"
    t.integer  "species_id"
    t.integer  "ability_id"
    t.integer  "item_id"
    t.integer  "nature_id"
    t.index ["ability_id"], name: "index_pokemons_on_ability_id"
    t.index ["item_id"], name: "index_pokemons_on_item_id"
    t.index ["nature_id"], name: "index_pokemons_on_nature_id"
    t.index ["species_id"], name: "index_pokemons_on_species_id"
    t.index ["user_id"], name: "index_pokemons_on_user_id"
  end

  create_table "requested", id: false, force: :cascade do |t|
    t.integer "trade_id"
    t.integer "requested_id"
  end

  create_table "resistances", id: false, force: :cascade do |t|
    t.integer "attacker_id"
    t.integer "defender_id"
  end

  create_table "species", force: :cascade do |t|
    t.string   "name"
    t.string   "form"
    t.integer  "dexno"
    t.float    "ratio"
    t.integer  "ability1_id"
    t.integer  "ability2_id"
    t.integer  "ability3_id"
    t.integer  "prevo_id"
    t.integer  "type1_id"
    t.integer  "type2_id"
    t.integer  "egg_group1_id"
    t.integer  "egg_group2_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "tm_moves", id: false, force: :cascade do |t|
    t.integer "species_id"
    t.integer "move_id"
    t.index ["move_id"], name: "index_tm_moves_on_move_id"
    t.index ["species_id"], name: "index_tm_moves_on_species_id"
  end

  create_table "trades", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tutor_moves", id: false, force: :cascade do |t|
    t.integer "species_id"
    t.integer "move_id"
    t.index ["move_id"], name: "index_tutor_moves_on_move_id"
    t.index ["species_id"], name: "index_tutor_moves_on_species_id"
  end

  create_table "types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",               default: "", null: false
    t.string   "ign"
    t.string   "friend_code"
    t.integer  "trainer_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weaknesses", id: false, force: :cascade do |t|
    t.integer "attacker_id"
    t.integer "defender_id"
  end

end
