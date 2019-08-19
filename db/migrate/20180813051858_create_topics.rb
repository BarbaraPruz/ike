# frozen_string_literal: true

# topics - the types of information in this knowledgebase
class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :name
      t.timestamps
    end
  end
end
