class AddNombreToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nombre, :string
  end
end
