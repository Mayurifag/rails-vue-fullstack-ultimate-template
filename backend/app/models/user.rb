class User < ApplicationRecord
  has_secure_password

  enum role: {regular: "regular", admin: "admin"}

  def is_able_to_reset_password?
    return false if reset_password_token_expires_at.blank?

    reset_password_token_expires_at > Time.current
  end
end
