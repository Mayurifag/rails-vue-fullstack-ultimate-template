module Users
  class SigninController < ApplicationController
    skip_before_action :authorize_access_request!, only: %i[create]

    def create
      user = User.find_by!(email: user_params[:email])
      if user.authenticate(user_params[:password])
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
          secure: JwtConfig.secure
        )

        render json: {csrf: tokens[:csrf]}
      else
        unauthorized
      end
    end

    def destroy
      session = JWTSessions::Session.new(payload: payload, namespace: "user_#{payload["user_id"]}")
      session.flush_by_access_payload
      head :ok
    end

    private

    KEYS = %i[email password].freeze
    private_constant :KEYS

    def user_params
      params.tap { |p| p.require(KEYS) }.permit(*KEYS)
    end
  end
end
