class RemoveInitialValuesFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_reference :users, :blacklist, foreign_key: true
  end
end
