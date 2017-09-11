class LineItemDecorator < Draper::Decorator
  delegate_all

  def price
    h.number_to_currency(object.price)
  end

  def subtotal
    h.number_to_currency(object.subtotal)
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
