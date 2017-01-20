class CreateMoves < ActiveRecord::Migration[5.0]
  def change
    create_table :moves do |t|
      t.string :name
      t.string :movetype
      t.string :category
      t.integer :power
      t.integer :accuracy

      t.integer :levelup_id
      t.integer :egg_id
      t.integer :tm_id
      t.integer :tutor_id
      t.integer :evolution_id

      t.timestamps
    end
  end
end
