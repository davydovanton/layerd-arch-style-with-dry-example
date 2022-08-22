# frozen_string_literal: true

RSpec.describe Shop::Types do
  describe 'AccountEmail' do
    let(:type) { Shop::Types::AccountEmail }

    context 'when account email is correct' do
      it { expect(type['test@shop.com']).to eq('test@shop.com') }
    end

    context 'when account email is invalid' do
      it { expect { type['test.com'] }.to raise_error(Dry::Types::ConstraintError) }
    end
  end

  describe 'OrderOpenStatus' do
    let(:type) { Shop::Types::OrderOpenStatus }

    context 'when order status is open' do
      it { expect(type['open']).to eq('open') }
    end

    context 'when order status is empty' do
      it { expect(type[]).to eq('open') }
    end

    context 'when order status is invalid' do
      it { expect { type[:open] }.to raise_error(Dry::Types::ConstraintError) }
      it { expect { type['payed'] }.to raise_error(Dry::Types::ConstraintError) }
      it { expect { type['invalid_status'] }.to raise_error(Dry::Types::ConstraintError) }
    end
  end

  describe 'OrderPayedStatus' do
    let(:type) { Shop::Types::OrderPayedStatus }

    context 'when order status is payed' do
      it { expect(type['payed']).to eq('payed') }
    end

    context 'when order status is empty' do
      it { expect(type[]).to eq('payed') }
    end

    context 'when order status is invalid' do
      it { expect { type[:payed] }.to raise_error(Dry::Types::ConstraintError) }
      it { expect { type['open'] }.to raise_error(Dry::Types::ConstraintError) }
      it { expect { type['invalid_status'] }.to raise_error(Dry::Types::ConstraintError) }
    end
  end

  describe 'OrderStatuses' do
    let(:type) { Shop::Types::OrderStatuses }

    context 'when order status is payed' do
      it { expect(type['open']).to eq('open') }
      it { expect(type['payed']).to eq('payed') }
    end

    context 'when order status is empty' do
      it { expect(type[]).to eq('open') }
    end

    context 'when order status is invalid' do
      it { expect { type[:open] }.to raise_error(Dry::Types::ConstraintError) }
      it { expect { type[:payed] }.to raise_error(Dry::Types::ConstraintError) }
      it { expect { type['invalid_status'] }.to raise_error(Dry::Types::ConstraintError) }
    end
  end
end
