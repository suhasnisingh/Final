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

  has_one  :own_artist, class_name: "Artist", foreign_key: "user_artist_id", dependent: :destroy


  has_many  :likes, class_name: "Like", foreign_key: "user_id", dependent: :destroy
  has_many  :comments, class_name: "Comment", foreign_key: "user_id", dependent: :nullify
  has_many  :received_follows, class_name: "Follow", foreign_key: "recipient_id", dependent: :destroy
  has_many  :sent_follows, class_name: "Follow", foreign_key: "sender_id", dependent: :destroy
  has_many  :projects, class_name: "Project", foreign_key: "user_id", dependent: :destroy
  has_many  :inspirations, class_name: "Inspiration", foreign_key: "user_id", dependent: :destroy


  has_many :followers, through: :received_follows, source: :sender
  has_many :recipients, through: :sent_follows, source: :recipient
  has_many :own_artworks, through: :own_artist, source: :artworks
  has_many :liked_artworks, through: :likes, source: :artwork
  has_many :commented_artworks, through: :comments, source: :artwork

end
