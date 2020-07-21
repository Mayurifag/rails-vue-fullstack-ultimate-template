# frozen_string_literal: true

# All the exceptions from application had to be handled here with jsons or whatever
module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from JWTSessions::Errors::Unauthorized do |exception|
      unauthorized(exception.message)
    end

    # rescue_from JWTSessions::Errors::ClaimsVerification do |exception|
    #   forbidden(exception.message)
    # end

    # rescue_from ActiveRecord::RecordNotFound do |exception|
    #   not_found(exception.message)
    # end

    rescue_from ActionController::ParameterMissing do |exception|
      bad_request(exception.message)
    end

    rescue_from ActiveRecord::RecordInvalid do |exception|
      record_invalid(exception.message)
    end

    rescue_from ResetPasswordError, with: :unauthorized
  end

  def unauthorized(message = "Unauthorized")
    json_response({error: message}, :unauthorized)
  end

  def record_invalid_with_full_messages(object)
    record_invalid(object.errors.full_messages.join(" "))
  end

  def record_invalid(message = "Record invalid")
    json_response({error: message}, :unprocessable_entity)
  end

  def not_found(message = "Not found")
    json_response({error: message}, :not_found)
  end

  def bad_request(message = "Bad request")
    json_response({error: message}, :bad_request)
  end

  # def forbidden(message = "Forbidden")
  #   json_response({error: message}, :forbidden)
  # end
end
