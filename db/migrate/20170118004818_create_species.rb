class CreateSpecies < ActiveRecord::Migration[5.0]
  def change
    create_table :species do |t|
    	t.string :name
    	t.string :form
    	t.integer :dexno

    	t.integer :ability1_id
    	t.integer :ability2_id
    	t.integer :ability3_id

        t.timestamps
    end
  end
end
