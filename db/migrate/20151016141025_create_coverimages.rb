class CreateCoverimages < ActiveRecord::Migration
  def change
    create_table :coverimages do |t|
      t.string :filename
      t.string :content_type
      t.binary :file_contents
      
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
