# frozen_string_literal: true

module CurrentCart
  include Dry::Monads[:try]

  private

  def set_cart
    cart = Try[ActiveRecord::RecordNotFound] { Cart.find(session[:cart_id]) }
    return @cart = cart.value! if cart.value?

    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  def ensure_cart_isnt_empty
    redirect_to(books_url, notice: t('cart_is_empty')) unless @cart.line_items.exists?
  end
end
