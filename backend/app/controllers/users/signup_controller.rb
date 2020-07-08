module Users
  class SignupController < ApplicationController
    skip_before_action :authorize_access_request!, only: %i[create]

    def create
      user = User.new(user_params)
      if user.save
        payload = {user_id: user.id, aud: [user.role]}
        session = JWTSessions::Session.new(
          payload: payload,
          refresh_by_access_allowed: true,
          namespace: "user_#{user.id}"
        )
        tokens = session.login
        response.set_cookie(
          JWTSessions.access_cookie,
          value: tokens[:access],
          httponly: true,
          secure: Rails.env.production?
        )

        json_response({csrf: tokens[:csrf]})
      else
        record_invalid(user.errors.full_messages.join(" "))
      end
    end

    private

    def user_params
      params.permit(:email, :password, :password_confirmation)
    end
  end
end
