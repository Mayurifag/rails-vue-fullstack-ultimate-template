class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :password, length: {minimum: 4, maximum: 40},
                       if: -> { new_record? || password.present? }

  def authorization_jwt_token
    {'Authorization': "Bearer #{KnockKnock::AuthToken.new(payload: {sub: id}).token}"}
  end
end
