class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true, length: { minimum: 6 }, uniqueness: true
  validates :email, presence: true, format: { with: /@/ }, uniqueness: true

  enum role: ["default", "admin"]
end
