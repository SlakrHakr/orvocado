class Position < ApplicationRecord
  has_many :reasons
  has_many :user_positions

  def selected?
    if self.class.current_user.nil?
      false
    else
      self.user_positions.any? { |user_position| user_position.user.id == self.class.current_user.id }
    end
  end
end
