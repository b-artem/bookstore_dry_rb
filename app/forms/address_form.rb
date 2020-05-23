# frozen_string_literal: true

class AddressForm < ApplicationForm
  attribute :type?, Types::String
  attribute :user_id?, Types::Integer
  attribute :order_id?, Types::Integer

  attribute :first_name?, Types::String
  attribute :last_name?, Types::String
  attribute :address?, Types::String
  attribute :city?, Types::String
  attribute :zip?, Types::String
  attribute :country?, Types::String
  attribute :phone?, Types::String

  def save
    return false unless valid?

    address = Address.find_or_initialize_by(order_id: order_id, user_id: user_id, type: type)
    address.update(attributes.except(:order_id, :user_id, :type))
  end

  def valid?
    @errors = AddressContract.new.call(attributes).errors.to_h
    errors.empty?
  end
end
