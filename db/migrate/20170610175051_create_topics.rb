class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.string  :description, null: false
      t.bigint :position_one, null: false
      t.bigint :position_two, null: false

      t.timestamps
    end
  end
end
