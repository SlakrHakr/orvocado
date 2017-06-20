class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.references :topic
      t.string :name

      t.timestamps
    end
  end
end
