# frozen_string_literal: true

# Module with current user methods
module CurrentUser
  def current_user
    @current_user ||= User.find(payload["user_id"])
  end
end
