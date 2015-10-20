class Addfromandcompany < ActiveRecord::Migration
  def change
    add_column :users, :sender, :string
    add_column :invs, :date, :string
  end
end
