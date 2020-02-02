require 'support/factory_girl'

RSpec.describe AuthorDecorator do
  let(:author) { build(:author) }

  describe '#name' do
    it 'contains first name + last name' do
      expect(author.decorate.name).to eq "#{author.first_name} #{author.last_name}"
    end
  end
end
