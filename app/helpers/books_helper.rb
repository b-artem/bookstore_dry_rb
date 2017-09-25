module BooksHelper
  def latest(quantity = 3)
    Book.order('created_at DESC').limit(quantity).decorate
  end
end
