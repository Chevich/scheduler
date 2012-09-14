class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :user_id, :null => false
      t.string :name, :null => false
      t.string :value, :null => false
      t.timestamps
    end
  end
end
