# frozen_string_literal: true

class Bookmark < ActiveRecord::Base
  validates :title, presence: true
  validates :article_id, presence: true
  validates :user_id, presence: true

  belongs_to :article
  belongs_to :user

  def article_title
    Article.find(article_id).title
  end

  def topic_id
    Article.find(article_id).topic_id
  end
end
