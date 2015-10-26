class Addordertoplines < ActiveRecord::Migration
  def change
    add_column :toplines, :position, :integer
  end
end
