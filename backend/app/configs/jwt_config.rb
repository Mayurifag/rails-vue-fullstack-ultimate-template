# frozen_string_literal: true

class JwtConfig < ApplicationConfig
  attr_config(
    encryption_key: "make_this_secret_for_production",
    secure: "false"
  )

  required :encryption_key
  required :secure
end
