class AddColumnsToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :upvotes, :integer
    add_column :posts, :downvotes, :integer
    add_column :posts, :flags, :integer
  end
end
