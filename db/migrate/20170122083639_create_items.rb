class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :spritename
      t.string :group

      t.timestamps
    end
  end
end
