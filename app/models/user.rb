class User < ApplicationRecord
  has_many :books, dependent: :destroy
  validates :username, presence: true, uniqueness: true, length: {minimum: 5, maximum: 25}
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}  
  has_secure_password

  before_save {self.email = email.downcase}
end
