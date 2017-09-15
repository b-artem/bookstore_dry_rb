require 'rails_helper'

RSpec.describe Forms::AddressForm, type: :model do



  context 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    # it { is_expected.to validate_inclusion_of(:type)
    #     .in_array(%w(BillingAddress ShippingAddress)) }
  end
end
