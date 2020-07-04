# Helpers to use with jsons
module JsonHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end
end
