class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :number
      t.timestamps
    end

    add_index :rooms, :number, :unique => true
  end
end
