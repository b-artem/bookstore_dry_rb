# frozen_string_literal: true

require 'support/factory_girl'

RSpec.describe ReviewDecorator do
  let(:review) { build(:review) }

  describe '#date' do
    it 'returns date in a correct format' do
      review.created_at = Time.zone.parse('2020-01-05 17:05:37')
      expect(review.decorate.date).to eql('05/01/20')
    end
  end
end
