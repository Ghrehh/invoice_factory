class Removingstuff < ActiveRecord::Migration
  def change
    remove_column :invs, :address1
    remove_column :invs, :address2
    remove_column :users, :current_group
    remove_column :users, :address
    remove_column :users, :mobile
    remove_column :users, :phone
    remove_column :users, :invoice_email
  end
end
