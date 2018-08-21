class User < ActiveRecord::Base
    has_secure_password

    has_many :bookmarks, dependent: :destroy
    has_many :articles, through: :bookmarks

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, on: :create

    before_save { |user| user.email = user.email.downcase }

    def self.find_or_create_by_omniauth(auth_hash)
        email = auth_hash[:info][:email]
        user = find_by(:email => email)
        if !user 
            user=User.create(:email => email, :password => SecureRandom.hex,
                :name => auth_hash[:info][:name])
        end
        user
    end
end
