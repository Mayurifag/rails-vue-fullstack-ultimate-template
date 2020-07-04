module Users
  class UsersController < ApplicationController
    def whoami
      json_response(current_user.as_json(only: [:id, :email, :role]))
    end
  end
end
