class User < ActiveRecord::Base
    has_secure_password

    has_many :bookmarks
    has_many :articles, through: :bookmarks

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, on: :create

    def self.create_with_omniauth(auth)
        binding.pry
        create! do |user|
          user.provider = auth["provider"]
          user.uid = auth["uid"]
          user.name = auth["info"]["name"]
        end
    end

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
