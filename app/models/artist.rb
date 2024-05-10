# == Schema Information
#
# Table name: artists
#
#  id             :integer          not null, primary key
#  artworks_count :integer
#  birth_year     :date
#  country        :string
#  name           :string
#  photo          :string
#  visibility     :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  inspiration_id :integer
#  user_artist_id :integer
#
class Artist < ApplicationRecord
end
