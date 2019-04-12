class RemoveInitialValuesFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_reference :posts, :flagposts, foreign_key: true
    remove_reference :posts, :dumpster, foreign_key: true
  end
end
