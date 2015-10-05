class CreateInvs < ActiveRecord::Migration
  def change
    create_table :invs do |t|

      t.timestamps null: false
      t.integer :user_id
      t.string :recipient
      
    end
  end
end
