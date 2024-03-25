class AddPaymentDetailsToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :card_number, :string
    add_column :orders, :expiry_date, :date
    add_column :orders, :cvv, :string
  end
end
