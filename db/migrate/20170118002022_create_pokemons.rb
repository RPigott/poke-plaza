class CreatePokemons < ActiveRecord::Migration[5.0]
  def change
    create_table :pokemons do |t|
      t.integer   :original_trainer_id
      t.string    :nickname
      t.integer   :level
      t.integer   :gender
      t.boolean   :shiny
      t.string    :nature
      t.string    :ability
      t.integer   :HPIV
      t.integer   :AtkIV
      t.integer   :DefIV
      t.integer   :SpAIV
      t.integer   :SpDIV
      t.integer   :SpeIV
      t.integer   :move1_id
      t.integer   :move3_id
      t.integer   :move2_id
      t.integer   :move4_id
      t.string    :ball

      t.timestamps

      t.belongs_to :user, :index => true
      t.belongs_to :species, :index => true
      t.belongs_to :ability, :index => true
      t.belongs_to :item, :index => true
      t.belongs_to :hiddenpower_id, :index => true
    end
  end
end
