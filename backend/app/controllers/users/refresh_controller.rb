module Users
  class RefreshController < ApplicationController
    skip_before_action :authorize_access_request!, only: %i[create]
    before_action :authorize_refresh_by_access_request!, only: %i[create]

    def create
      session = JWTSessions::Session.new(
        payload: claimless_payload,
        refresh_by_access_allowed: true,
        namespace: "user_#{claimless_payload["user_id"]}"
      )
      tokens = session.refresh_by_access_payload {
        raise JWTSessions::Errors::Unauthorized, "Malicious activity detected"
      }
      response.set_cookie(JWTSessions.access_cookie,
        value: tokens[:access],
        httponly: true,
        secure: Rails.env.production?)

      json_response({csrf: tokens[:csrf]})
    end
  end
end
