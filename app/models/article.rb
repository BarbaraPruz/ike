class Article < ActiveRecord::Base
  belongs_to :topic
  has_many :bookmarks, dependent: :destroy
  has_many :users, through: :bookmarks
  has_many :comments
  has_many :likes, dependent: :destroy

  validates :title, presence: true
  validates :topic, presence: true

  def self.sort_by(sort_column)
    order = ['likes', 'updated_at'].include?(sort_column) ? :desc : :asc
    if sort_column == 'topic'
      Article.joins(:topic).merge(Topic.order(name: order))
    else
      Article.order("#{sort_column} #{order}")
    end
  end

  def topic_name
    topic ? topic.name : nil
  end

  def new_topic=(data)
    Topic.find_or_create_by(name: data) unless data.empty?
  end

  def new_topic
  end

  def self.get_latest(number_articles)
    last(number_articles).sort { |x, y| y.created_at <=> x.created_at }
  end
end
