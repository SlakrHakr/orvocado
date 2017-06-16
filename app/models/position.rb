class Position < ApplicationRecord
  has_many :reasons
  has_many :user_positions

  def selected?
    self.user_positions.any? { |user_position| user_position.user.name == 'SlakrHakr' }
  end
end
