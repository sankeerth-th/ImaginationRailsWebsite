class CreateContestEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :contest_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :contest, null: false, foreign_key: true
      t.references :potion, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
