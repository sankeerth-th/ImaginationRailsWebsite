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

class Vendor < ApplicationRecord
  
  # Associations
  has_many :potions, dependent: :destroy
  belongs_to(
     :userobj,
     class_name:  'User',
     foreign_key: 'user_id',
     inverse_of:  :vendor
      )

  has_many(
     :potions,
     class_name:  'Potion',
     foreign_key: 'vendor_id',
     inverse_of:  :vendor
   )

  has_many(
    :contests,
    class_name:  'Contest',
    foreign_key: 'vendor_id',
    inverse_of:  :vendor
  )
  # Validations
  validates :business_name, presence: true
  validates :desc, presence: true

  def related_orders
    Order.joins(:potions).where(potions: { vendor_id: id }).distinct
  end

  # Add any other necessary validations or methods
end