class Bookmark  < ActiveRecord::Base
    belongs_to :article
    belongs_to :user

    def article_title
        Article.find_by(:id => self.article_id).title
    end
    def topic_id
        Article.find(self.article_id).topic_id
    end

    def self.clean(article_id)
        self.where(:article_id => article_id).each { |bookmark| 
            bookmark.destroy
        }
    end
end
