# frozen_string_literal: true

class RemoveHelpfulCountFromArticles < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :helpful_count, :integer
  end
end
