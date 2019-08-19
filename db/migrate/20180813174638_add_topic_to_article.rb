# frozen_string_literal: true

# Article belongs to a topic (for better browsing functions)
class AddTopicToArticle < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :topic, index: true, foreign_key: true
  end
end
