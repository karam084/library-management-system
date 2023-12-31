class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :isbn
      t.string :email
      t.boolean :checkout
      t.boolean :request
      t.boolean :bookmarks

      t.timestamps
    end
  end
end
