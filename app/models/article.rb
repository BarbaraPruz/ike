class Article  < ActiveRecord::Base
    belongs_to :topic
    has_many :bookmarks, dependent: :destroy
    has_many :users, through: :bookmarks
    
    validates :title, presence: true
    validates :topic, presence: true
    
    def self.sort_by (sort_column)
        order = ["helpful_count", "updated_at"].include?(sort_column) ? :desc : :asc
        if sort_column == "topic"
            Article.joins(:topic).merge(Topic.order(name: order))
        else
            Article.order("#{sort_column} #{order}")
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
        self.last(number_articles).sort { |x,y| y.created_at <=> x.created_at }
    end
end
