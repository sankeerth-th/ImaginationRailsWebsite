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
require "test_helper"

class PotionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
