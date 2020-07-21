module Users
  class SigninController < BaseUsersController
    skip_before_action :authorize_access_request!, only: %i[create]

    def create
      if user.authenticate(user_params[:password])
        set_response_access_cookie
        json_response({csrf: tokens[:csrf]})
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

    def user
      @user ||= User.find_by!(email: user_params[:email])
    end
  end
end
