class AddCountToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :count, :integer
  end
end
