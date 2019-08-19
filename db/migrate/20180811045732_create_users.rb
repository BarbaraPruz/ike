# frozen_string_literal: true

# users table
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :provider
      t.string :uid
      t.string :password_digest
      t.boolean :admin, default: false
      t.timestamps
    end
  end
end
