class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string    :username
      t.string    :ign
      t.string   :friend_code
      t.integer	  :trainer_id

      t.timestamps
    end
  end
end
