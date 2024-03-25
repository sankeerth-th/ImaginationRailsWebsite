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
require "test_helper"

class ContestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
