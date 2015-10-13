class Floater2 < ActiveRecord::Migration
  def change
    change_column :lines, :price, :float
  end
end
