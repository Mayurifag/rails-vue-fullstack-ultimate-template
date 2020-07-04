# frozen_string_literal: true

# Main application controller, consists of modules
class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include CurrentUser
  include JWTSessions::RailsAuthorization

  # Any request, except skipped further ones has to be authorized via jwt
  before_action :authorize_access_request!
end
