class CreateMoves < ActiveRecord::Migration[5.0]
  def change
    create_table :moves do |t|
      t.string :name
      t.string :movetype
      t.string :category
      t.integer :power
      t.integer :accuracy

      t.timestamps
    end
  end
end
