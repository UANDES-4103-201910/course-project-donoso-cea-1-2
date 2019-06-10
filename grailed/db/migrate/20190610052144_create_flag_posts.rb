class CreateFlagPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :flag_posts do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.string :reason

      t.timestamps
    end
  end
end
