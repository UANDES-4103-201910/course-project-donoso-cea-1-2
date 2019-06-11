class AddBlacklistedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :blacklisted, :string
  end
end
