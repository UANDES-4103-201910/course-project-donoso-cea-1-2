class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :city
      t.string :country
      t.string :security
      t.string :status
      t.string :visible

      t.timestamps
    end
  end
end
