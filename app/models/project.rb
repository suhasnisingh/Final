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
end
