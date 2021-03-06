# frozen_string_literal: true

module Validations
  private

  def positive_integer?(string)
    return false if Float(string) <= 0

    true if (Float(string) - Integer(string)) == 0
  rescue StandardError
    false
  end
end
