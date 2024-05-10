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
end
