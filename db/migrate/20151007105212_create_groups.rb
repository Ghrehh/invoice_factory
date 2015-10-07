class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      
      t.string :name
      t.integer :user_id
      

      t.timestamps null: false
    end
    
  add_column :invs, :group_id, :integer
  add_column :users, :current_group, :string, :null => false, :default => "all"
  end
end
