# frozen_string_literal: true

class AddIndexToLikes < ActiveRecord::Migration[5.2]
  def change
    add_index :likes, [:article_id, :user_id], unique: true
  end
end
