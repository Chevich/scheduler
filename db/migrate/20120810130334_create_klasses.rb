class CreateKlasses < ActiveRecord::Migration
  def change
    create_table :klasses do |t|
      t.integer :user_id, :null => false
      t.string :name, :null => false
      t.integer :level, :null => false
      t.timestamps
    end
    add_index :klasses, [:user_id, :name], :unique => true
  end
end
