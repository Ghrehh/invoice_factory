class Addinvoiceparams < ActiveRecord::Migration
  def change
    add_column :users, :address, :string
    add_column :users, :mobile, :string
    add_column :users, :phone, :string
    add_column :users, :invoice_email, :string
    
    add_column :invs, :address_1, :string
    add_column :invs, :address_2, :string
    add_column :invs, :address_3, :string
  end
end
