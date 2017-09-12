class OrderDecorator < Draper::Decorator
  delegate_all

  def item_total
    h.number_to_currency(object.item_total)
  end

  def order_total
    h.number_to_currency(object.order_total)
  end

  def completed_at
    object.completed_at.strftime("%B %e, %Y")
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
