class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :user_id, :null => false
      t.string :name, :null => false
      t.string :number, :null => false
      t.timestamps
    end

    add_index :rooms, [:user_id, :number], :unique => true
  end
end
