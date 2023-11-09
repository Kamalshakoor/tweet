class AddLikesCountToTwets < ActiveRecord::Migration[6.1]
  def change
      add_column :twets, :likes_count, :integer, default: 0
  end
end
