class UserReasonAgreement < ApplicationRecord
  belongs_to :user
  belongs_to :reason
end
