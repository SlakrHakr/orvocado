class CreateReasons < ActiveRecord::Migration[5.0]
  def change
    create_table :reasons do |t|
      t.references :position, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :description, null: false
      t.bigint :score, null: false, default: 0

      t.timestamps
    end
  end
end
