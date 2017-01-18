class CreatePokemons < ActiveRecord::Migration[5.0]
  def change
    create_table :pokemons do |t|
      t.string    :species
      t.integer   :trainer_id
      t.string    :nickname
      t.string    :gender
      t.boolean   :shiny
      t.string    :nature
      t.string    :ability
      t.integer   :HPIV
      t.integer   :AtkIV
      t.integer   :DefIV
      t.integer   :SpAIV
      t.integer   :SpDIV
      t.integer   :SpeIV
      t.string    :hiddenpower
      t.string    :move1
      t.string    :move3
      t.string    :move2
      t.string    :move4

      t.timestamps
    end
  end
end
