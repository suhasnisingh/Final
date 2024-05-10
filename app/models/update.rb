# == Schema Information
#
# Table name: updates
#
#  id         :integer          not null, primary key
#  body       :text
#  photo      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :integer
#
class Update < ApplicationRecord
  belongs_to :project, required: true, class_name: "Project", foreign_key: "project_id", counter_cache: true
  
end
