# Serialized user whoami json
module Users
  class WhoamiBlueprint < Blueprinter::Base
    identifier :id

    fields :email, :role
  end
end
