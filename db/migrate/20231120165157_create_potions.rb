class CreatePotions < ActiveRecord::Migration[7.0]
  def change
    create_table :potions do |t|
      t.string :name
      t.string :effect
      t.text :source_description
      t.string :origin
      t.string :potency
      t.string :duration
      t.string :category
      t.integer :recommended_age
      t.references :vendor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
