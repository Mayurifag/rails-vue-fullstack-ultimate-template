module Users
  class UsersController < BaseUsersController
    def whoami
      json_response(Users::WhoamiBlueprint.render_as_json(current_user))
    end
  end
end
