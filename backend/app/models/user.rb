class User < ApplicationRecord
  has_secure_password

  enum role: {regular: "regular", admin: "admin"}

  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP},
                    presence: true,
                    uniqueness: {case_sensitive: false}
  validates :password_digest, presence: true
end
