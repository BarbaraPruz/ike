# frozen_string_literal: true

class Topic < ActiveRecord::Base
  has_many :articles

  validates :name, presence: true, uniqueness: true

  def article_ids
    articles.all.map(&:id)
  end
end
