# == Schema Information
#
# Table name: artworks
#
#  id             :integer          not null, primary key
#  comments_count :integer
#  description    :string
#  likes_count    :integer
#  location       :string
#  photo          :string
#  title          :string
#  visibility     :boolean
#  year           :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  artist_id      :integer
#  inspiration_id :integer
#  project_id     :integer
#  style_id       :integer
#
class Artwork < ApplicationRecord

  belongs_to :artist, required: true, class_name: "Artist", foreign_key: "artist_id", counter_cache: true
  has_many  :likes, class_name: "Like", foreign_key: "artwork_id", dependent: :destroy
  has_many  :comments, class_name: "Comment", foreign_key: "artwork_id", dependent: :destroy
  belongs_to :style, class_name: "Style", foreign_key: "style_id", counter_cache: true
  belongs_to :project, class_name: "Project", foreign_key: "project_id", counter_cache: true

  ## double check
  belongs_to :inspiration, class_name: "Inspiration", foreign_key: "inspiration_id", counter_cache: true

  has_one  :user_artist, through: :artist, source: :user_artist
  has_many :liking_users, through: :likes, source: :user
  has_many :commenting_users, through: :comments, source: :user

end
