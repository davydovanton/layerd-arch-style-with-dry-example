# frozen_string_literal: true

RSpec.describe Shop::Entities::Account, type: :entity do
  let(:account) { described_class.new(payload) }

  let(:payload) do
    {
      id: 1,
      name: 'Anton',
      email: 'test@test.com',
      address: 'test'
    }
  end


  it { expect(account.id).to eq(1) }
end
