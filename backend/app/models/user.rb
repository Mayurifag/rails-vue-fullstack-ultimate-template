class User < ApplicationRecord
  has_secure_password

  enum role: {regular: "regular", admin: "admin"}

  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP},
                    presence: true,
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 4, maximum: 40}
  validates :password_digest, presence: true

  def generate_password_token!
    loop do
      self.reset_password_token = SecureRandom.urlsafe_base64
      break unless User.exists?(reset_password_token: reset_password_token)
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
