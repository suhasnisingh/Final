# == Schema Information
#
# Table name: artists
#
#  id             :integer          not null, primary key
#  artworks_count :integer
#  birth_year     :date
#  country        :string
#  name           :string
#  photo          :string
#  visibility     :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  artist_api_id  :string
#  inspiration_id :integer
#  user_artist_id :integer
#
class Artist < ApplicationRecord

  ## double check
  belongs_to :user_artist, class_name: "User", foreign_key: "user_artist_id"

  has_many  :artworks, class_name: "Artwork", foreign_key: "artist_id", dependent: :destroy
  belongs_to :inspiration, class_name: "Inspiration", foreign_key: "inspiration_id", counter_cache: true
  has_many :styles, through: :artworks, source: :style
  
end
