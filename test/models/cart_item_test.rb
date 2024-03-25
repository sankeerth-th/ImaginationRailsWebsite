# == Schema Information
#
# Table name: cart_items
#
#  id         :bigint           not null, primary key
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cart_id    :bigint           not null
#  potion_id  :bigint           not null
#
# Indexes
#
#  index_cart_items_on_cart_id    (cart_id)
#  index_cart_items_on_potion_id  (potion_id)
#
# Foreign Keys
#
#  fk_rails_...  (cart_id => carts.id)
#  fk_rails_...  (potion_id => potions.id)
#
require "test_helper"

class CartItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
