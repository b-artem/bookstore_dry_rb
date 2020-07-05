# frozen_string_literal: true

class PaymentForm < ApplicationForm
  attribute :card_number?, Types::String
  attribute :name_on_card?, Types::String
  attribute :valid_until?, Types::String
  attribute :cvv?, Types::String

  def model_name
    nil
  end

  def save
    valid?
  end

  def valid?
    @errors = PaymentContract.new.call(attributes).errors.to_h
    errors.empty?
  end
end
