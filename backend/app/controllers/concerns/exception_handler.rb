# frozen_string_literal: true

# All the exceptions from application had to be handled here with jsons or whatever
module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from JWTSessions::Errors::Unauthorized do |exception|
      unauthorized(exception.message)
    end

    rescue_from JWTSessions::Errors::ClaimsVerification do |exception|
      forbidden(exception.message)
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
      not_found(exception.message)
    end

    rescue_from ActionController::ParameterMissing do |exception|
      bad_request(exception.message)
    end

    rescue_from ActiveRecord::RecordInvalid do |exception|
      record_invalid(exception.message)
    end
  end

  def unauthorized(message = "Unauthorized")
    json_response({errors: message}, :unauthorized)
  end

  def record_invalid(message = "Record invalid")
    json_response({errors: message}, :unprocessable_entity)
  end

  def not_found(message = "Not found")
    json_response({errors: message}, :not_found)
  end

  def bad_request(message = "Bad request")
    json_response({errors: message}, :bad_request)
  end

  def forbidden(message = "Forbidden")
    json_response({errors: message}, :forbidden)
  end
end
