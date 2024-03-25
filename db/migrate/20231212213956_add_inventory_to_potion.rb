class AddInventoryToPotion < ActiveRecord::Migration[7.0]
  def change
    add_column :potions, :stock, :integer
    add_reference :contests, :winner, null: true, foreign_key: { to_table: :contest_entries }
  end
end
