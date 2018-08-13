class AddTopicToArticle < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :topic, index: true, foreign_key: true
  end
end
