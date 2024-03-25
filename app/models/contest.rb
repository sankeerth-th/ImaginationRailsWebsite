# == Schema Information
#
# Table name: contests
#
#  id         :bigint           not null, primary key
#  desc       :text
#  end_date   :datetime
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  vendor_id  :bigint           not null
#  winner_id  :bigint
#
# Indexes
#
#  index_contests_on_vendor_id  (vendor_id)
#  index_contests_on_winner_id  (winner_id)
#
# Foreign Keys
#
#  fk_rails_...  (vendor_id => vendors.id)
#  fk_rails_...  (winner_id => contest_entries.id)
#
class Contest < ApplicationRecord
    belongs_to(
        :vendor,
        class_name:  'Vendor',
        foreign_key: 'vendor_id',
        inverse_of:  :contests
   )
   has_one_attached :image
   has_one(
    :winner,
    class_name:  'ContestEntry',
    foreign_key: 'id',
    inverse_of:  :contest_won
   )
   has_many :contest_entries
end
