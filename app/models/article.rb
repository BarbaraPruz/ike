class Article  < ActiveRecord::Base
    belongs_to :topic
    has_many :bookmarks
    has_many :users, through: :bookmarks
    
    validates :title, presence: true
    validates :topic, presence: true
    
    def new_topic=(data)
        if !data.empty?
            self.topic = Topic.create(:name => data)
        end
    end
    def new_topic
    end

    def self.get_latest (number_articles)
        self.last(number_articles)
    end
end
