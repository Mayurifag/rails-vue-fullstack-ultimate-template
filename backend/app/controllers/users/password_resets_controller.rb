module Users
  class PasswordResetsController < ApplicationController
    before_action :set_user, only: [:show, :update]
    skip_before_action :authorize_access_request!, only: %i[create show update]

    def create
      user = User.find_by(email: params[:email])
      if user
        user.generate_password_token!
        UserMailer.reset_password(user).deliver_now
      end

      json_response("Mail should be delivered to your email if it exists in system")
    end

    # TODO: возможно не нужно
    def show
      render json: :ok
    end

    def update
      @user.update!(password_params)
      @user.clear_password_token!
      JWTSessions::Session.new(namespace: "user_#{@user.id}").flush_namespaced
      json_response("Password successfully updated")
    end

    private

    KEYS = %i[password password_confirmation].freeze
    private_constant :KEYS

    def password_params
      params.tap { |p| p.require(KEYS) }.permit(*KEYS)
    end

    def set_user
      @user = User.find_by(reset_password_token: params[:token])
      raise ResetPasswordError unless @user&.reset_password_token_expires_at && @user.reset_password_token_expires_at > Time.current
    end
  end
end
