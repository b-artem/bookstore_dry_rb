class HomeController < ApplicationController
  def index
    @categories = Category.all
    @latest_books = Book.order('created_at DESC').limit(3)
  end
end
