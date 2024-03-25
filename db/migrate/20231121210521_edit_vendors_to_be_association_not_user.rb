class EditVendorsToBeAssociationNotUser < ActiveRecord::Migration[7.0]
  def change

    ## Remove Devise Stuff
    remove_column :vendors, :encrypted_password
    remove_column :vendors, :reset_password_token
    remove_column :vendors, :reset_password_sent_at
    remove_column :vendors, :remember_created_at
    remove_column :vendors, :email
    remove_column :vendors, :contact
    remove_column :vendors, :name
    remove_column :vendors, :phone_number

    ## Add Class Diagram Vendor Stuff
    add_column :vendors, :desc, :text
    add_index :vendors, :id, unique: true

    ### Add Relationship between user and vendor
    add_reference :vendors, :user, foreign_key: true
  end
end
