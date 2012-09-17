class AddDayNumToKlasses < ActiveRecord::Migration
  def change
    add_column :klasses, :days, :string, :default => '1,2,3,4,5,6'
  end
end
