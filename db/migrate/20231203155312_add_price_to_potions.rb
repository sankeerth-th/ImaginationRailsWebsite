class AddPriceToPotions < ActiveRecord::Migration[7.0]
  def change
    add_column :potions, :price, :decimal
  end
end
