# frozen_string_literal: true

class JwtConfig < ApplicationConfig
  attr_config encryption_key: "make_this_secret_for_production"

  required :encryption_key
end
