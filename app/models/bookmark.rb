class Bookmark  < ActiveRecord::Base
    belongs_to :article
    belongs_to :user

    def article_title
        Article.find(self.article_id).title
    end
    def topic_id
        Article.find(self.article_id).topic_id
    end
end
