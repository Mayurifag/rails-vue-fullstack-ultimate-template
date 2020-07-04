class User < ApplicationRecord
  has_secure_password

  enum role: {regular: "regular", admin: "admin"}

  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP},
                    presence: true,
                    uniqueness: {case_sensitive: false}
  validates :password_digest, presence: true

  # TODO: move these to handlers
  def generate_password_token!
    self.reset_password_token = loop do
      random_token = SecureRandom.urlsafe_base64
      break random_token unless self.class.exists?(reset_password_token: random_token)
    end
    self.reset_password_token_expires_at = 1.day.from_now
    save!
  end

  def clear_password_token!
    self.reset_password_token = nil
    self.reset_password_token_expires_at = nil
    save!
  end
end
