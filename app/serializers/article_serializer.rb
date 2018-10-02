class ArticleSerializer < ActiveModel::Serializer
    attributes :id, :title, :content, :helpful_count, :updated_at
    belongs_to :topic
    has_many :comments
  end