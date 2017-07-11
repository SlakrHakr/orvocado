class Position < ApplicationRecord
  has_many :reasons, -> { order(score: :desc) }
  has_many :user_positions

  def selected?
    if self.class.current_user.nil?
      false
    else
      begin
        self.user_positions.any? { |user_position| user_position.user.id == self.class.current_user.id }
      rescue
        false
      end
    end
  end
end
