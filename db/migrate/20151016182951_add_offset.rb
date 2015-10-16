class AddOffset < ActiveRecord::Migration
  def change
    add_column :users, :topoffset, :integer
  end
end
