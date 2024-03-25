class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :cart_item, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :total_price

      t.timestamps
    end
  end
end
