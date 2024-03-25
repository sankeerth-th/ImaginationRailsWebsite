# == Schema Information
#
# Table name: order_items
#
#  id          :bigint           not null, primary key
#  quantity    :integer
#  total_price :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  order_id    :bigint           not null
#  potion_id   :bigint           not null
#
# Indexes
#
#  index_order_items_on_order_id   (order_id)
#  index_order_items_on_potion_id  (potion_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (potion_id => potions.id)
#
class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :potion
end
