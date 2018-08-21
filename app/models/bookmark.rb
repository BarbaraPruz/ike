class Bookmark  < ActiveRecord::Base
    validates :title, presence: true
    validates :article_id, presence: true
    validates :user_id, presence: true

    belongs_to :article
    belongs_to :user

    def article_title
        Article.find_by(:id => self.article_id).title
    end
    def topic_id
        Article.find(self.article_id).topic_id
    end

end
