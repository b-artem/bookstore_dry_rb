class Order < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :shipping_method, optional: true
  has_one :billing_address, dependent: :destroy
  has_one :shipping_address, dependent: :destroy
  # accepts_nested_attributes_for :billing_address, :shipping_address
  has_many :line_items, dependent: :destroy

  after_create :generate_number

  aasm column: 'state' do
    state :in_progress, initial: true
    state :in_queue, :in_delivery, :delivered, :canceled

    event :pay do
      transitions from: :in_progress, to: :in_queue

      after do
        update_attributes(completed_at: Time.now)
      end
    end

    # event :to_delivery do
    #   transitions from: :in_queue, to: :in_delivery
    # end
  end

  def shipping_address
    return super unless self[:use_billing_address_as_shipping]
    billing_address
  end

  def item_total
    return 0 unless line_items.any?
    line_items.sum(&:subtotal)
  end

  def order_total
    return item_total unless shipping_method
    item_total + shipping_method.price
  end

  private

    def generate_number
      number = id.to_s.prepend('R' + '0' * (8 - id.to_s.length))
      update_attributes(number: number)
    end
end
