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
end
