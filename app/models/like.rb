class Like < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  def self.user_article_not_liked_yet?(user_id, article_id)
    !Like.where(user_id: user_id, article_id: article_id).exists?
  end
end
