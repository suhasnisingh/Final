# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  artwork_id :integer
#  user_id    :integer
#
class Comment < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id", counter_cache: true
  belongs_to :artwork, required: true, class_name: "Artwork", foreign_key: "artwork_id", counter_cache: true
end
