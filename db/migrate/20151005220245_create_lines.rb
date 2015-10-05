class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|

      t.timestamps null: false
      t.integer :inv_id
      t.string :service
      t.string :description
      t.integer :price
    end
  end
end
