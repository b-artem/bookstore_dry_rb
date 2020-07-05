# frozen_string_literal: true

module CurrentOrder
  include Dry::Monads[:try]

  private

  def set_current_order(order)
    session[:order_id] = order.id
  end

  def current_order
    order = Try[ActiveRecord::RecordNotFound] { Order.uncached { Order.find(session[:order_id]) } }
    return order.value! if order.value?

    flash[:alert] = t('order_was_not_found', order_id: session[:order_id])
  end

  def empty_current_order
    session.delete :order_id
  end
end
