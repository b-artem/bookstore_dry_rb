# frozen_string_literal: true

class ReviewDecorator < Draper::Decorator
  delegate_all

  def date
    I18n.l(created_at, format: :date_slashes)
  end
end
