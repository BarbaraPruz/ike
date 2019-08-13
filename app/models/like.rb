class Like < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  def self.userArticleNotLikedYet? (user_id, article_id) 
    !Like.where(user_id: user_id, article_id: article_id).exists?
  end
end
