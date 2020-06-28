# frozen_string_literal: true

# Helpers for request tests. Handle auth and json parsing
module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end
end
