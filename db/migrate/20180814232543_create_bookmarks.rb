class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.integer :article_id
      t.integer :user_id
      t.string  :name
      t.timestamps
    end
  end
end
