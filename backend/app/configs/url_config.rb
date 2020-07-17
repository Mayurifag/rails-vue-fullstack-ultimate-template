# frozen_string_literal: true

class UrlConfig < ApplicationConfig
  attr_config(
    scheme: "http://",
    host: "localhost",
    port: "3333"
  )

  on_load :ensure_scheme_is_valid

  required :scheme
  required :host
  required :port

  def base_url
    host + port
  end

  def base_url_with_scheme
    scheme + base_url
  end

  def ensure_scheme_is_valid
    unless ["http://", "https://"].include?(scheme)
      raise_validation_error "Unknown scheme: #{scheme}"
    end
  end
end
