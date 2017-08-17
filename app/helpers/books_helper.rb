module BooksHelper
  def best_sellers(quantity = 4)
    Book.order('price DESC').limit(quantity).decorate
  end
end
