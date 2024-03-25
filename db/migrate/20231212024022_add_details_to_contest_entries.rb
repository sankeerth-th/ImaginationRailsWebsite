class AddDetailsToContestEntries < ActiveRecord::Migration[7.0]
  def change
    add_column :contest_entries, :potion_name, :string
  end
end
