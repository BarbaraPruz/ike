# frozen_string_literal: true

# LikesTable - add index to enforce uniqueness
# of relationship (user can only like article once)
class AddIndexToLikes < ActiveRecord::Migration[5.2]
  def change
    add_index :likes, [:article_id, :user_id], unique: true
  end
end
