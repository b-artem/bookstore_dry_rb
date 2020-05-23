# frozen_string_literal: true

RSpec.shared_context 'payment info', shared_context: :metadata do
  def payment_info
    {
      card_number: rand(1_000_000_000_000_000..9_999_999_999_999_999).to_s,
      name_on_card: "#{Faker::Name.first_name.tr("'", '')} #{Faker::Name.last_name.tr("'", '')}",
      valid_until: (Time.zone.today + rand(0..120).months).strftime('%m/%y'),
      cvv: rand(100..9999).to_s
    }
  end
end
