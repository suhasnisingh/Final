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
end
