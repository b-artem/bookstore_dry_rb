class BookDecorator < Draper::Decorator
  delegate_all
  decorates_association :authors

  def authors_names
    authors.map(&:name).join(', ')
  end

  def short_description
    h.truncate(description, length: 500)
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
