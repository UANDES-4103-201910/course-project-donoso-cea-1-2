class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :user_id, foreign_key: true
      t.references :post_id, foreign_key: true
      t.string :vote

      t.timestamps
    end
  end
end
