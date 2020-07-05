# frozen_string_literal: true

class AddCouponToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :coupon, foreign_key: true
  end
end
