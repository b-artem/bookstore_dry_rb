module BooksHelper
  def best_sellers(quantity = 4)
    # HAVE TO CHANGE IT
    Book.order('price DESC').limit(quantity).decorate
  end

  def latest(quantity = 3)
    Book.order('created_at DESC').limit(quantity).decorate
  end
end
