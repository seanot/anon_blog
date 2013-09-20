class User < ActiveRecord::Base
  has_many :posts

  validates :email, uniqueness: true
  validates :password, presence: true

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return user if user && (user.password == password)
  end
end
