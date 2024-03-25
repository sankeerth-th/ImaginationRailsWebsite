class RemovePasswordDigestFromVendors < ActiveRecord::Migration[7.0]
  def change
    remove_column :vendors, :password_digest, :string
  end
end
