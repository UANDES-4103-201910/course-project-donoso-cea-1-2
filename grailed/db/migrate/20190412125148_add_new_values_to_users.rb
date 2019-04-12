class AddNewValuesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :votes, foreign_key: true
    add_reference :users, :comments, foreign_key: true
    add_reference :users, :posts, foreign_key: true
    add_reference :users, :blacklist, foreign_key: true
  end
end
