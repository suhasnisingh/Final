# == Schema Information
#
# Table name: inspirations
#
#  id             :integer          not null, primary key
#  artists_count  :integer
#  artworks_count :integer
#  description    :string
#  name           :string
#  other_notes    :string
#  projects_count :integer
#  visibility     :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#
class Inspiration < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id", counter_cache: true
  has_one  :project, class_name: "Project", foreign_key: "inspiration_id", dependent: :nullify
  has_many  :artists, class_name: "Artist", foreign_key: "inspiration_id", dependent: :nullify
  has_many  :artworks, class_name: "Artwork", foreign_key: "inspiration_id", dependent: :nullify
end
