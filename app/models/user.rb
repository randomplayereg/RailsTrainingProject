class User < ApplicationRecord

  has_many :books, dependent: :destroy

  validates :username, presence: true
  validates :username, uniqueness: true,
  validates :username, length: {minimum: 5, maximum: 25}

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: {with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}

  has_secure_password

  before_save {self.email = email.downcase}
end
