class Tag < ApplicationRecord
  validates_presence_of :topic_id
  validates_presence_of :name

  belongs_to :topic
end
