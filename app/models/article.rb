class Article  < ActiveRecord::Base
    belongs_to :topic
    has_many :bookmarks
    has_many :users, through: :bookmarks
    
    validates :title, presence: true
    validates :topic, presence: true
    
end
