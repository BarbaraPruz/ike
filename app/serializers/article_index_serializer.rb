class ArticleIndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :helpful_count, :updated_at
  belongs_to :topic
end
