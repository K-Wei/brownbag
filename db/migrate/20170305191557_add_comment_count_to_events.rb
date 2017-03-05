class AddCommentCountToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :comments_count, :integer
  end
end
