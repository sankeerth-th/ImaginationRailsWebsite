# == Schema Information
#
# Table name: contest_votes
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  contest_entry_id :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_contest_votes_on_contest_entry_id  (contest_entry_id)
#  index_contest_votes_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (contest_entry_id => contest_entries.id)
#  fk_rails_...  (user_id => users.id)
#
class ContestVote < ApplicationRecord
    belongs_to :user
    belongs_to :contest_entry
end
