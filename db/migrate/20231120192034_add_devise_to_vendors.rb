class AddDeviseToVendors < ActiveRecord::Migration[7.0]
  def self.up
    change_table :vendors do |t|
      ## Database authenticatable
      # Remove or comment out the next line if the email column already exists
      # t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # Uncomment the following lines if you want to use tracking
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # Uncomment the following lines if you want to use confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # Uncomment the following lines if you want to use lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps null: false
    end

    add_index :vendors, :email,                unique: true
    add_index :vendors, :reset_password_token, unique: true
    # add_index :vendors, :confirmation_token,   unique: true
    # add_index :vendors, :unlock_token,         unique: true
  end

  def self.down
    # You can define how to roll back this migration here.
    # Be sure to remove or comment out any fields that were not originally added.
  end
end
