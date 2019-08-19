# frozen_string_literal: true

# Update - for user likes to be unique, need a likes table
class RemoveHelpfulCountFromArticles < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :helpful_count, :integer
  end
end
