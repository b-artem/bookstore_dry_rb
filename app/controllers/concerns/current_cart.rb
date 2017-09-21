module CurrentCart

  private

    def set_cart
      @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end

    def ensure_cart_isnt_empty
      redirect_to(books_url, notice: 'Your cart is empty') unless @cart.line_items.any?
    end

    def destroy_cart
      # return unless @cart
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      session[:discount_id] = nil
    end
end
