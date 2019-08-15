class Topic < ActiveRecord::Base
  has_many :articles

  validates :name, presence: true, uniqueness: true

  def article_ids
    self.articles.all.map { |article| article.id }
  end
end
