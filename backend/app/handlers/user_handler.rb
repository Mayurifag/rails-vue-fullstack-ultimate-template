class UserHandler
  def initialize(user)
    @user = user
  end

  def generate_password_token!
    @user.reset_password_token = loop do
      random_token = SecureRandom.urlsafe_base64
      break random_token unless @user.class.exists?(reset_password_token: random_token)
    end
    @user.reset_password_token_expires_at = 1.day.from_now
    @user.save! if @user.persisted?
  end

  def clear_password_token!
    @user.reset_password_token = nil
    @user.reset_password_token_expires_at = nil
    @user.save! if @user.persisted?
  end
end
