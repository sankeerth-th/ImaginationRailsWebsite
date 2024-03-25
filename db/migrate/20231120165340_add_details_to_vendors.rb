class AddDetailsToVendors < ActiveRecord::Migration[7.0]
  def change
    add_column :vendors, :name, :string
    add_column :vendors, :business_name, :string
    add_column :vendors, :contact, :string
    add_column :vendors, :phone_number, :string
  end
end
