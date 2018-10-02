class CommentSerializer < ActiveModel::Serializer
  attributes :id, :article_id, :user_id, :author_name, :content, :updated_at
end
