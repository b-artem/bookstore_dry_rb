class HomeController < ApplicationController
  def index
    @latest_books = Book.order('created_at DESC').limit(3)
  end
end
