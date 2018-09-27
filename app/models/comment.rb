class Comment < ActiveRecord::Base
    validates :content, presence: true
    validates :article_id, presence: true
    validates :user_id, presence: true

    belongs_to :article
    belongs_to :user
    
    def author_name
        author = User.find_by(:id => user_id)
        author ? author.name : "anonymous"  # anonymous should neveer happen but just in case!
    end
end
