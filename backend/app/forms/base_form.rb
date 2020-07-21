class BaseForm
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include ShallowAttributes

  # def persisted?
  #   false
  # end
end
