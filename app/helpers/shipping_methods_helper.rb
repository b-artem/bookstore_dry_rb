module ShippingMethodsHelper
  def shipping_methods
    ShippingMethod.order('price ASC')
  end
end
