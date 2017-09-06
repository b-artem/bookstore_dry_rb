module CurrentOrder

  private

    def set_current_order(order)
      session[:order_id] = order.id
    end

    def current_order
      Order.find(session[:order_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Order #{session[:order_id]} was not found"
    end

    def empty_current_order
      session[:order_id] = nil
    end

end
