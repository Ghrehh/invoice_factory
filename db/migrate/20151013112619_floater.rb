class Floater < ActiveRecord::Migration
  def change
    change_column :invs, :total, :float
    
  end
end
