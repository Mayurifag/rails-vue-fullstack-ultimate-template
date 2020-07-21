module Users
  class SignupController < BaseUsersController
    skip_before_action :authorize_access_request!, only: %i[create]

    def create
      return record_invalid_with_full_messages(form) unless form.valid?

      user.save!
      set_response_access_cookie
      json_response({csrf: tokens[:csrf]})
    end

    private

    KEYS = %i[email password password_confirmation].freeze
    private_constant :KEYS

    def user_params
      params.tap { |p| p.require(KEYS) }.permit(*KEYS)
    end

    def form
      @form ||= Users::SignupForm.new(user_params)
    end

    def user
      @user ||= User.new(user_params)
    end
  end
end
