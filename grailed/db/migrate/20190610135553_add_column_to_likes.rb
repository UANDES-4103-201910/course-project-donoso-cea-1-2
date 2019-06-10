class AddColumnToLikes < ActiveRecord::Migration[5.2]
  def change
    add_column :likes, :value2, :string
  end
end
