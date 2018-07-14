class Position < ApplicationRecord
  validates_presence_of :description

  has_many :reasons, -> { order(score: :desc) }
  has_many :user_positions

  def selected_count
    UserPosition.all.where( :position_id => self[:id] ).count
  end

  def selected?
    if self.class.current_user.nil?
      false
    else
      begin
        self.user_positions.any? { |user_position| user_position.user.nil? ? false : user_position.user.id == self.class.current_user.id }
      rescue
        false
      end
    end
  end
end
