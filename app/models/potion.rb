# == Schema Information
#
# Table name: potions
#
#  id                 :bigint           not null, primary key
#  category           :string
#  duration           :string
#  effect             :string
#  name               :string
#  origin             :string
#  potency            :string
#  price              :decimal(, )
#  recommended_age    :integer
#  source_description :text
#  stock              :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  vendor_id          :bigint           not null
#
# Indexes
#
#  index_potions_on_vendor_id  (vendor_id)
#
# Foreign Keys
#
#  fk_rails_...  (vendor_id => vendors.id)
#
class Potion < ApplicationRecord
  belongs_to(
       :vendor,
       class_name:  'Vendor',
       foreign_key: 'vendor_id',
       inverse_of:  :potions
  )
  has_many_attached :images
  validates :price, presence: true, numericality: { greater_than: 0 }
end
