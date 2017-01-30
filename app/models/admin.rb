class Admin < ActiveRecord::Base

  REGEX_EMAIL = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 30}
  validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 200}, format: {with: REGEX_EMAIL}

  has_secure_password

end
