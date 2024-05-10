# == Schema Information
#
# Table name: projects
#
#  id              :integer          not null, primary key
#  artworks_count  :integer
#  completed_photo :string
#  desription      :text
#  finish_date     :date
#  other_notes     :text
#  start_date      :date
#  status          :string
#  title           :string
#  updates_count   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  inspiration_id  :integer
#  user_id         :integer
#
class Project < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id", counter_cache: true
  has_one  :artwork, class_name: "Artwork", foreign_key: "project_id", dependent: :nullify
  has_many  :updates, class_name: "Update", foreign_key: "project_id", dependent: :destroy
  
  ## double check
  belongs_to :inspiration, class_name: "Inspiration", index: { unique: true }, foreign_key: "inspiration_id", counter_cache: true
end
