class CreateUserReasonAgreements < ActiveRecord::Migration[5.0]
  def change
    create_table :user_reason_agreements do |t|
      t.references :user, foreign_key: true
      t.references :reason, foreign_key: true

      t.timestamps
    end
  end
end
