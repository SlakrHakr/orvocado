class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.string  :description
      t.integer :position_one
      t.integer :position_two

      t.timestamps
    end
  end
end
