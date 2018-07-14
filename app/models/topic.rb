class Topic < ApplicationRecord
  validates_presence_of :description
  validates_presence_of :position_one
  validates_presence_of :position_two

  self.per_page = 40
  has_many :tags

  def position_one
    (self.errors.add(:base, :position_one) and return nil) if self.attributes['position_one'].blank?
  	Position.find(self.attributes['position_one'])
  end

  def position_one_perc
    sum = self.position_one.selected_count + self.position_two.selected_count
    sum > 0 ? self.position_one.selected_count.to_f / (sum.to_f) * 100 : 0
  end

  def position_two
    (self.errors.add(:base, :position_two) and return nil) if self.attributes['position_two'].blank?
  	Position.find(self.attributes['position_two'])
  end

  def position_two_perc
    sum = self.position_one.selected_count + self.position_two.selected_count
    sum > 0 ? self.position_two.selected_count.to_f / (sum.to_f) * 100 : sum
  end
end
