class CreateSpecies < ActiveRecord::Migration[5.0]
  def change
    create_table :species do |t|
    	t.string  :name
    	t.string  :form
    	t.integer :dexno
        t.float   :ratio

        t.integer :ability1_id
        t.integer :ability2_id
        t.integer :ability3_id

        t.integer :prevo_id

        t.integer :type1_id
        t.integer :type2_id
        
        t.integer  :egg_group1_id
        t.integer  :egg_group2_id
        
        t.timestamps
    end
  end
end
