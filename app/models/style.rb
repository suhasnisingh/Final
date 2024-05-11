# == Schema Information
#
# Table name: styles
#
#  id             :integer          not null, primary key
#  artworks_count :integer
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Style < ApplicationRecord

  has_many  :artworks, class_name: "Artwork", foreign_key: "style_id", dependent: :nullify

  has_many :artists, through: :artworks, source: :artist
  
end
