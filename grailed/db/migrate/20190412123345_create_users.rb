class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :picture
      t.text :bio
      t.string :city
      t.string :country
      t.string :role

      t.timestamps
    end
  end
end
