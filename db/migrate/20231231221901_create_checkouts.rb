class CreateCheckouts < ActiveRecord::Migration[7.0]
  def change
    create_table :checkouts do |t|
      t.references :book, null: false, foreign_key: true
      t.date :issue_date
      t.date :return_date
      t.integer :validity
      #t.references :student, null: false, foreign_key: true


      t.timestamps
    end
  end
end
