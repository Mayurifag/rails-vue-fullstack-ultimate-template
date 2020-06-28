# frozen_string_literal: true

# Main application controller, consists of modules
class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include KnockKnock::Authenticable
  before_action :authenticate_user
end
