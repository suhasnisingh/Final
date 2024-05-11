# == Schema Information
#
# Table name: follows
#
#  id           :integer          not null, primary key
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#
class Follow < ApplicationRecord
  belongs_to :recipient, required: true, class_name: "User", foreign_key: "recipient_id", counter_cache: :received_follows_count
  belongs_to :sender, required: true, class_name: "User", foreign_key: "sender_id", counter_cache: :sent_follows_count
end
