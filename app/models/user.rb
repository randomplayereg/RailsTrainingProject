class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: {minimum: 5, maximum: 25}
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}
end
