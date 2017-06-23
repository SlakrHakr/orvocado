class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.references :topic, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
