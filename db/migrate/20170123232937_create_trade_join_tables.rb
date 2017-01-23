class CreateTradeJoinTables < ActiveRecord::Migration[5.0]
  def change
  	create_table :offered, id: false do |t|
  		t.integer :trade_id
  		t.integer :offered_id
  	end

  	create_table :requested, id: false do |t|
  		t.integer :trade_id
  		t.integer :requested_id
  	end
  end
end
