class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.text :body

      t.integer :poster_id
      t.integer :postee_id

      t.timestamps
    end
  end
end
