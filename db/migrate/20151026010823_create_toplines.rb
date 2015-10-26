class CreateToplines < ActiveRecord::Migration
  def change
    
    create_table :toplines do |t|
      t.integer :user_id
      
      t.string :name
      t.string :value
      
      t.timestamps null: false
    end
    
    add_column :users, :use_picture, :boolean, :null => false, :default => false
    add_column :invs, :note, :text
    add_column :invs, :due_date, :string
  end
end
