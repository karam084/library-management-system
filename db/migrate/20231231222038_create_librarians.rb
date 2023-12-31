class CreateLibrarians < ActiveRecord::Migration[7.0]
  def change
    create_table :librarians do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :library
      t.string :approved

      t.timestamps
    end
  end
end
