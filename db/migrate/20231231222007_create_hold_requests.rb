class CreateHoldRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :hold_requests do |t|
     # t.references :student, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
