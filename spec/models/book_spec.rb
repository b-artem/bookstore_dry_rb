require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Book, type: :model do
  let(:book) { build(:book) }

  it "has a valid factory" do
    expect(book).to be_valid
  end

  describe "ActiveModel validations" do
    # Basic validations

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:image_url) }
    it { is_expected.to validate_presence_of(:publication_year) }
    it { is_expected.to validate_presence_of(:dimensions) }
    it { is_expected.to validate_presence_of(:materials) }

    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0.01) }
    it 'validates uniqueness of #title' do
      expect(book).to validate_uniqueness_of(:title)
    end
    it { is_expected.to allow_value('1.gif').for(:image_url) }
    it { is_expected.to allow_value('1.png').for(:image_url) }
    it { is_expected.to allow_value('1.jpg').for(:image_url) }
    it { is_expected.to_not allow_value('1.psd').for(:image_url) }
    it { is_expected.to validate_inclusion_of(:publication_year).in_range(1969..Date.today.year) }

    # it { expect(bodybuilder).to validate_presence_of(:food).with_message(/you can't get big without your protein!/)
    # it { expect(tumblog).to validate_numericality_of(:follower_count).only_integer }
    # it { expect(wishlist).to validate_uniqueness_of(:product).scoped_to(:user_id, :wishlist_id).with_message("You can only have an item on your wishlist once.") }

    # Format validations
    # it { expect(user).to allow_value("JSON Vorhees").for(:name) }
    # it { expect(user).to_not allow_value("Java").for(:favorite_programming_language) }
    # it { expect(user).to allow_value("dhh@nonopinionated.com").for(:email) }
    # it { expect(user).to_not allow_value("base@example").for(:email) }
    # it { expect(user).to_not allow_value("blah").for(:email) }
    # it { expect(blog).to allow_blank(:connect_to_facebook) }
    # it { expect(blog).to allow_nil(:connect_to_facebook) }

    # Inclusion/acceptance of values
    # it { expect(tumblog).to ensure_inclusion_of(:status).in_array(['draft', 'public', 'queue']) }
    # it { expect(tng_group).to ensure_inclusion_of(:age).in_range(18..35) }
    # it { expect(band).to ensure_length_of(:bio).is_at_least(25).is_at_most(1000) }
    # it { expect(tweet).to ensure_length_of(:content).is_at_most(140) }
    # it { expect(applicant).to ensure_length_of(:ssn).is_equal_to(9) }
    # it { expect(contract).to validate_acceptance_of(:terms) }  # For boolean values
    # it { expect(user).to validate_confirmation_of(:password) }  # Ensure two values match
  end

end
