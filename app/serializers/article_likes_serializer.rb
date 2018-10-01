class ArticleLikesSerializer < ActiveModel::Serializer
    attributes :id, :helpful_count
end