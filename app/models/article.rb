require 'pry'
class Article  < ActiveRecord::Base
    belongs_to :topic
    has_many :bookmarks, dependent: :destroy
    has_many :users, through: :bookmarks
    
    validates :title, presence: true
    validates :topic, presence: true
    
    def self.sort_by (column)
        if column == "topic"
            Article.joins(:topic).merge(Topic.order(name: :asc))
        else
            Article.order(column)
        end
    end

    def topic_name
        self.topic.name
    end

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
