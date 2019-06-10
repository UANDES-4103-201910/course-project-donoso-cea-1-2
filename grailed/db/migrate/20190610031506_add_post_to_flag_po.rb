class AddPostToFlagPo < ActiveRecord::Migration[5.2]
  def change
    add_column :flag_pos, :post, :reference
  end
end
