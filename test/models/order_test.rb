# == Schema Information
#
# Table name: orders
#
#  id               :bigint           not null, primary key
#  card_number      :string
#  cvv              :string
#  expiry_date      :date
#  payment_method   :string
#  shipping_address :string
#  status           :string
#  total            :decimal(, )
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
