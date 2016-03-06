class User < ActiveRecord::Base
  has_secure_password
  has_many :orders

  validates :username, presence: true, length: { minimum: 6 }, uniqueness: true
  validates :email, presence: true, format: { with: /@/ }, uniqueness: true
end
