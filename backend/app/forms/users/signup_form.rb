module Users
  class SignupForm < BaseForm
    private

    attribute :email, String
    attribute :password, String
    attribute :password_confirmation, String

    validates :password, :password_confirmation, :email, presence: true
    validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}

    validate :lowercased_email_is_unique
    validate :password_and_confirmation_equality

    def password_and_confirmation_equality
      return if password == password_confirmation

      errors.add(:password_confirmation, "has to be equal with password")
    end

    def lowercased_email_is_unique
      return if email.blank?

      lowercased_email = email.downcase
      if User.where(email: lowercased_email).exists?
        errors.add(:email, "is already taken")
      end
    end
  end
end
