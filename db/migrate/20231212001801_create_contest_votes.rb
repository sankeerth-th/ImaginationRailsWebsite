class CreateContestVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :contest_votes do |t|
      t.references :contest_entry, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    remove_reference :contest_entries, :potion, index: true, foreign_key: true
  end
end
