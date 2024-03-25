class AddVendorFkToContest < ActiveRecord::Migration[7.0]
  def change
    add_reference :contests, :vendor, null:false, foreign_key: true
    add_column :contests, :end_date, :datetime
  end
end
