class CreateVendors < ActiveRecord::Migration[7.0]
  def change
    create_table :vendors do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
