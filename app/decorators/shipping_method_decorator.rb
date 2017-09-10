class ShippingMethodDecorator < Draper::Decorator
  delegate_all

  def terms
    "#{days_min} to #{days_max} days"
  end

  def price
    h.number_to_currency(object.price)
  end
end
