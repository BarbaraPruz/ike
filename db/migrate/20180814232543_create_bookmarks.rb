# frozen_string_literal: true

# User can bookmark articles of interest
class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.integer :article_id
      t.integer :user_id
      t.string  :title
      t.timestamps
    end
  end
end
