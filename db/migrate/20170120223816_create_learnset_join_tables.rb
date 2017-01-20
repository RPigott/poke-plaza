class CreateLearnsetJoinTables < ActiveRecord::Migration[5.0]
  def change
    create_table :levelup_moves, id: false do |t|
      t.integer :species_id
      t.integer :move_id
    end
    add_index :levelup_moves, :species_id
    add_index :levelup_moves, :move_id

    create_table :egg_moves, id: false do |t|
      t.integer :species_id
      t.integer :move_id
    end
    add_index :egg_moves, :species_id
    add_index :egg_moves, :move_id

    create_table :tm_moves, id: false do |t|
      t.integer :species_id
      t.integer :move_id
    end
    add_index :tm_moves, :species_id
    add_index :tm_moves, :move_id

    create_table :tutor_moves, id: false do |t|
      t.integer :species_id
      t.integer :move_id
    end
    add_index :tutor_moves, :species_id
    add_index :tutor_moves, :move_id

    create_table :evolution_moves, id: false do |t|
      t.integer :species_id
      t.integer :move_id
    end
    add_index :evolution_moves, :species_id
    add_index :evolution_moves, :move_id

  end
end
