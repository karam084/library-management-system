class AddColumnToStudent < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :provider, :string
    add_column :students, :uid, :string
  end
end
