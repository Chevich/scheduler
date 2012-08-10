class CreateKlasses < ActiveRecord::Migration
  def change
    create_table :klasses do |t|
      t.string :name
      t.string :level
      t.timestamps
    end
    add_index :klasses, :name, :unique => true
  end
end
