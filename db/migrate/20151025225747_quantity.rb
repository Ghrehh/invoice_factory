class Quantity < ActiveRecord::Migration
  def change
    add_column :lines, :quantity, :integer
  end
end
