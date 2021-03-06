# frozen_string_literal: true

# Articles - the heart of knowledgebase
class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string  :title
      t.text    :content
      t.integer :helpful_count, default: 0
      t.timestamps
    end
  end
end
