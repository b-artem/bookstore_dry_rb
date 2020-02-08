class ApplicationForm < Dry::Struct
  module Types
    include Dry::Types(default: :nominal)
  end

  transform_keys(&:to_sym)

  # The methods below are needed to work with SimpleForm

  def model_name
    ActiveModel::Name.new(self.class.to_s.gsub('Form', '').constantize)
  end

  def to_key
    defined?(id) ? id : nil
  end
end
