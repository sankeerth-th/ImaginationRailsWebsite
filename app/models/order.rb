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
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :potions, through: :order_items  # Only if you need to directly access potions from an order

  validates :shipping_address, presence: true
  validates :card_number, presence: true, format: { with: /\A\d{16}\z/ }
  validates :expiry_date, presence: true
  validates :cvv, presence: true, length: { in: 3..4 }
  # Add other necessary validations
end
