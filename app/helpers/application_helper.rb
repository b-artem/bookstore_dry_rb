module ApplicationHelper
  def back_path
    session[:back_path] || books_path
  end
end
