# == Schema Information
#
# Table name: contest_entries
#
#  id          :bigint           not null, primary key
#  description :text
#  potion_name :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  contest_id  :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_contest_entries_on_contest_id  (contest_id)
#  index_contest_entries_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (contest_id => contests.id)
#  fk_rails_...  (user_id => users.id)
#
class ContestEntry < ApplicationRecord
  belongs_to :user
  belongs_to :contest
  has_one_attached :image
  has_many :contest_votes
  belongs_to(
    :contest_won,
    class_name:  'Contest',
    foreign_key: 'winner_id',
    inverse_of:  :winner,
    optional: true
)
  validates :description, presence: true
  validates :potion_name, presence: true
end
