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
end
