class Bookmark  < ActiveRecord::Base
    validates :title, presence: true
    validates :article_id, presence: true
    validates :user_id, presence: true

    belongs_to :article
    belongs_to :user

    def article_title
        Article.find(self.article_id).title
    end
    def topic_id
        Article.find(self.article_id).topic_id
    end
    def username
        user = User.find_by(:id => self.user_id)
        user ? user.name : nil
    end
    def self.latest
        self.order(created_at: :desc)
    end
end
