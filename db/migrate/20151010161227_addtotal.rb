class Addtotal < ActiveRecord::Migration
  def change
    add_column :invs, :total, :integer
  end
end
