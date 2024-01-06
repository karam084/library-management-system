class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :authors
      t.string :language
      t.string :published
      t.string :edition
      t.string :cover
      t.string :subject
      t.text :summary
      t.string :category
      t.boolean :special_collection
      t.references :library, null: false, foreign_key: true

      t.timestamps
     end
  end
end

  