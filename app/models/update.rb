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
end
