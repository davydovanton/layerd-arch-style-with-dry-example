# frozen_string_literal: true

RSpec.describe Shop::Entities::Order, type: :entity do
  let(:order) { described_class.new(payload) }

  let(:payload) do
    {
      id: 1,
      account_id: 1,
      status: 'open'
    }
  end

  it { expect(order.id).to eq(1) }

  describe '#payed?' do
    subject { order.payed? }

    context 'when order status is "open"' do
      let(:payload) { { id: 1, account_id: 1, status: 'open' } }

      it { expect(subject).to eq(false) }
    end

    context 'when order status is "payed"' do
      let(:payload) { { id: 1, account_id: 1, status: 'payed' } }

      it { expect(subject).to eq(true) }
    end
  end
end
