# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord

  has_one(
    :vendor,
    class_name:  'Vendor',
    foreign_key: 'user_id',
    inverse_of:  :userobj
  )
  has_one :cart
  
  has_many(
    :comments,
    class_name:  'Comment',
    foreign_key: 'user_id',
    inverse_of:  :user
  )

  has_many :orders
  has_many :contest_entries
  has_many :contest_votes



  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:user]
end
