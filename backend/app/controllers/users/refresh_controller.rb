module Users
  class RefreshController < BaseUsersController
    skip_before_action :authorize_access_request!, only: %i[create]
    before_action :authorize_refresh_by_access_request!, only: %i[create]

    def create
      set_response_access_cookie
      json_response({csrf: tokens[:csrf]})
    end

    private

    def session
      @session ||= JWTSessions::Session.new(
        payload: claimless_payload,
        refresh_by_access_allowed: true,
        namespace: "user_#{claimless_payload["user_id"]}"
      )
    end

    def tokens
      @tokens ||= session.refresh_by_access_payload {
        raise JWTSessions::Errors::Unauthorized, "Malicious activity detected"
      }
    end
  end
end
