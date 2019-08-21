# frozen_string_literal: true

# Like model joins a user to an article
class Like < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  validates_uniqueness_of :user_id,
                          scope: :article_id,
                          message: 'You can only like an article once!'
end
