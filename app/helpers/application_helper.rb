# frozen_string_literal: true

module ApplicationHelper
  def back_path
    request.referer || books_path
  end
end
