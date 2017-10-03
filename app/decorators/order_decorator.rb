class OrderDecorator < Draper::Decorator
  delegate_all

  def subtotal
    h.number_to_currency(object.subtotal)
  end

  def total
    h.number_to_currency(object.total)
  end

  def completed_at
    object.completed_at.strftime("%B %e, %Y")
  end

  def completed_at_full_date
    return t('orders.orders.index.not_completed') unless object.completed_at
    object.completed_at.strftime("%Y-%m-%d")
  end

  def discount
    h.number_to_currency(object.discount)
  end

  def state
    return t('orders.orders.filter.waiting_for_processing') if object.state == 'in_queue'
    object.state.titleize
  end
end
