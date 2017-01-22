class CreateEffectivenessJoinTables < ActiveRecord::Migration[5.0]
  def change
  	create_table :resistances, id: false do |t|
  	  t.integer :attacker_id
  	  t.integer :defender_id
  	end

  	create_table :weaknesses, id: false do |t|
  	  t.integer :attacker_id
  	  t.integer :defender_id
  	end

  	create_table :immunities, id: false do |t|
  	  t.integer :attacker_id
  	  t.integer :defender_id
  	end
  end
end
