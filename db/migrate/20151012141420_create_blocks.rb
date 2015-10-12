class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|

      t.timestamps null: false
      t.integer :user_id
      t.integer :inv_id
      t.text :body
    end
  end
end
