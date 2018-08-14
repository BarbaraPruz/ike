class User < ActiveRecord::Base
    has_secure_password

    has_many :bookmarks
    has_many :articles, through: :bookmarks

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, on: :create
end
