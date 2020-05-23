# frozen_string_literal: true

require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Book do
  let(:book) { build(:book) }

  it 'has a valid factory' do
    expect(book).to be_valid
  end

  describe 'Associations' do
    it { is_expected.to have_and_belong_to_many(:authors) }
    it { is_expected.to have_and_belong_to_many(:categories) }
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
    it { is_expected.to have_many(:line_items) }
  end

  describe 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:publication_year) }
    it { is_expected.to validate_presence_of(:dimensions) }
    it { is_expected.to validate_presence_of(:materials) }

    it {
      is_expected.to validate_numericality_of(:price)
        .is_greater_than_or_equal_to(0.01)
    }

    it 'validates uniqueness of :title' do
      expect(book).to validate_uniqueness_of(:title).case_insensitive
    end

    it {
      is_expected.to validate_inclusion_of(:publication_year)
        .in_range(1969..Time.zone.today.year)
    }

    describe 'destroy' do
      let(:book) { create(:book) }

      context 'when line items exist' do
        before { create(:line_item, book: book) }

        it 'adds does NOT destroy a book' do
          expect(book.destroy).to be false
          expect(book.errors[:base]).to contain_exactly(I18n.t('models.book.referenced_by_line_items'))
        end
      end
    end
  end

  describe 'scopes' do
    context 'best_seller' do
      let(:bestseller_mob_dev) { create :book_mobile_development }
      let(:bestseller_photo) { create :book_photo }
      let(:bestseller_web_design) { create :book_web_design }
      let(:bestseller_web_dev) { create :book_web_development }

      before do
        create(:order, state: 'delivered', line_items: [
                 create(:line_item, book: bestseller_mob_dev),
                 create(:line_item, book: bestseller_photo),
                 create(:line_item, book: bestseller_web_design),
                 create(:line_item, book: bestseller_web_dev)
               ])
        create_list(:book_mobile_development, 3)
        create_list(:book_photo, 3)
        create_list(:book_web_design, 3)
        create_list(:book_web_development, 3)
      end

      context "when category 'Mobile development'" do
        it 'selects best seller in proper category' do
          expect(described_class.best_seller('Mobile development')).to eq bestseller_mob_dev
        end
      end

      context "when category 'Photo'" do
        it 'selects best seller in proper category' do
          expect(described_class.best_seller('Photo')).to eq bestseller_photo
        end
      end

      context "when category 'Web design'" do
        it 'selects best seller in proper category' do
          expect(described_class.best_seller('Web design')).to eq bestseller_web_design
        end
      end

      context "when category 'Web development'" do
        it 'selects best seller in proper category' do
          expect(described_class.best_seller('Web development')).to eq bestseller_web_dev
        end
      end
    end

    describe '.popular_first_ids' do
      before { create(:book) }

      context 'when no line items exist' do
        it 'returns empty relation' do
          expect(described_class.popular_first_ids).to eq described_class.none
        end
      end
    end
  end
end
