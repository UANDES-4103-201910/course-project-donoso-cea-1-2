class CreateFlagPos < ActiveRecord::Migration[5.2]
  def change
    create_table :flag_pos do |t|
      t.references :user, foreign_key: true
      t.references :post
      t.text :reason

      t.timestamps
    end
  end
end
