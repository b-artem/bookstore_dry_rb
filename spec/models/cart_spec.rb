require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Cart, type: :model do
  let(:cart) { build :cart }

  it 'has valid factory' do
    expect(cart).to be_valid
  end

  describe 'Associations' do
    it { is_expected.to have_many(:line_items).dependent(:destroy) }
  end

  describe 'Instance methods' do
    let(:cart) { create :cart }
    let(:book) { create :book }

    describe '#add_product' do
      context 'when number is positive integer' do
        context 'when product is not in cart yet' do
          it 'adds product to cart' do
            expect { cart.add_product(book, 3) }.to change {
              cart.line_items.length }.by 1
          end
        end

        context 'when product is already in cart' do
          it 'increase quantity of product in cart' do
            cart.add_product(book, 1).save
            expect { cart.add_product(book, 2).save }.to change {
              cart.line_items.first.quantity }.from(1).to(3)
          end
        end
      end

      context 'when number is negative' do
        it 'does not add product' do
          expect { cart.add_product(book, -3) }.not_to change {
            cart.line_items.length }
        end
      end

      context 'when number is not integer' do
        it 'does not add product' do
          expect { cart.add_product(book, 3.27) }.not_to change {
            cart.line_items.length }
        end
      end
    end
  end
end
