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

  attr_reader :address, :errors

  def save
    return false unless valid?

    @address = attributes[:id] ? Address.find_by(id: attributes[:id]) : Address.new
    address.attributes = attributes.except(:id)
    address.save
  end

  def valid?
    @errors = AddressContract.new.call(to_hash).errors.to_hash
    errors.empty?
  end
end
