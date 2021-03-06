# frozen_string_literal: true

# Comments for an article
class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :article_id
      t.integer :user_id
      t.text :content
      t.timestamps
    end
  end
end
