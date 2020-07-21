module Users
  class BaseUsersController < ApplicationController
    private

    def user_payload
      @user_payload ||= {user_id: user.id, aud: [user.role]}
    end

    def set_response_access_cookie
      response.set_cookie(
        JWTSessions.access_cookie,
        value: tokens[:access],
        httponly: true,
        secure: JwtConfig.secure
      )
    end

    def tokens
      @tokens ||= begin
        session = JWTSessions::Session.new(
          payload: user_payload,
          refresh_by_access_allowed: true,
          namespace: "user_#{user.id}"
        )

        session.login
      end
    end
  end
end
