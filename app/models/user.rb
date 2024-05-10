# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  birth_year             :date
#  comments_count         :integer
#  country                :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  inspirations_count     :integer
#  likes_count            :integer
#  name                   :string
#  own_artists_count      :integer
#  photo                  :string
#  projects_count         :integer
#  received_follows_count :integer
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sent_follows_count     :integer
#  visibility             :boolean
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
