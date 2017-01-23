class CreateNatures < ActiveRecord::Migration[5.0]
  def change
    create_table :natures do |t|
      t.string :name
      t.string :positive
      t.string :negative

      t.timestamps
    end
  end
end
