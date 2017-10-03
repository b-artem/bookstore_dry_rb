require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Book, type: :model do
  let(:book) { build(:book) }

  it "has a valid factory" do
    expect(book).to be_valid
  end

  describe 'Associations' do
    it { is_expected.to have_and_belong_to_many(:authors) }
    it { is_expected.to have_and_belong_to_many(:categories) }
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
    it { is_expected.to have_many(:line_items) }
  end

  describe "ActiveModel validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:publication_year) }
    it { is_expected.to validate_presence_of(:dimensions) }
    it { is_expected.to validate_presence_of(:materials) }

    it { is_expected.to validate_numericality_of(:price).
                        is_greater_than_or_equal_to(0.01) }
    it 'validates uniqueness of :title' do
      expect(book).to validate_uniqueness_of(:title).case_insensitive
    end
    it { is_expected.to validate_inclusion_of(:publication_year).
                        in_range(1969..Date.today.year) }
  end

  describe 'scopes' do
    let!(:books_mobile_development) { create_list(:book_mobile_development, 3) }
    let!(:books_photo) { create_list(:book_photo, 3) }
    let!(:books_web_design) { create_list(:book_web_design, 3) }
    let!(:books_web_development) { create_list(:book_web_development, 3) }

    context 'when .mobile_development' do
      it 'selects books with proper category' do
        expect(Book.mobile_development).to eq books_mobile_development
      end
    end

    context 'when .photo' do
      it 'selects books with proper category' do
        expect(Book.photo).to eq books_photo
      end
    end

    context 'when .web_design' do
      it 'selects books with proper category' do
        expect(Book.web_design).to eq books_web_design
      end
    end

    context 'when .web_development' do
      it 'selects books with proper category' do
        expect(Book.web_development).to eq books_web_development
      end
    end
  end
end
