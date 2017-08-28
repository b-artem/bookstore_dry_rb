module Validations

  private

    def positive_integer?(string)
      true if ( Float(string) - Integer(string) ) == 0
    rescue
      false
    end
end
