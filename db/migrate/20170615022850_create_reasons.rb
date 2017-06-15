class CreateReasons < ActiveRecord::Migration[5.0]
  def change
    create_table :reasons do |t|
      t.integer :position_id
      t.string :description

      t.timestamps
    end
  end
end
