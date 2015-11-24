class AddTutorialComplete < ActiveRecord::Migration
  def change
    add_column :users, :tutorial_complete, :boolean, :null => false, :default => false
  end
end
