class CreateFlagPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :flag_posts do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.text :reason

      t.timestamps
    end
  end
end
