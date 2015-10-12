class CreateBlocks < ActiveRecord::Migration
  def change
    add_column :invs, :block, :text
  end
end
