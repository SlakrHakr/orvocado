class Topic < ApplicationRecord
  self.per_page = 40
  has_many :tags

  def position_one
  	Position.find(self.attributes['position_one'])
  end

  def position_two
  	Position.find(self.attributes['position_two'])
  end
end
