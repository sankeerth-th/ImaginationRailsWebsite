# == Schema Information
#
# Table name: vendors
#
#  id            :bigint           not null, primary key
#  business_name :string
#  desc          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint
#
# Indexes
#
#  index_vendors_on_id       (id) UNIQUE
#  index_vendors_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class VendorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
