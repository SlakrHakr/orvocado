class Reason < ApplicationRecord
  validates_presence_of :position_id
  validates_presence_of :description

  belongs_to :position
  belongs_to :user, optional: true
  has_many :user_reason_agreement

  def agree?
    if self.class.current_user.nil?
      false
    else
      begin
        self.user_reason_agreement.any? { |urg| urg.user.id == self.class.current_user.id }
      rescue
        false
      end
    end
  end
end
