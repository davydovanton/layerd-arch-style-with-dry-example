# frozen_string_literal: true

RSpec.describe HTTP::Actions::Commands::Checkout, type: :http_action do
  let(:action) { described_class.new(command: command) }

  subject { action.call(env_params) }
  let(:session) { { account_id: 12 } }
  let(:env_params) do
    {
      'rack.session' => session,
      id: 1
    }
  end

  context 'when command complete business logic correct' do
    let(:command) { ->(*) { Success({ order: { id: 1 } }) } }

    it { expect(subject.status).to eq(200) }
    it { expect(subject.body.first).to eq({ order: { id: 1 } }.to_json) }

    it 'calls command with right data' do
      expect(command).to receive(:call).with(order_id: 1, account_id: 12).and_return(Success(:done))
      subject
    end
  end

  context 'when command failed' do
    context 'and order or (and) account not founded' do
      let(:command) { ->(*) { Failure([:order_and_account_not_founded, { error: 'order_and_account_not_found' }]) } }

      it { expect(subject.status).to eq(404) }
      it { expect(subject.body.first).to eq({ error: 'order_and_account_not_found' }.to_json) }

      it 'calls command with right data' do
        expect(command).to receive(:call).with(order_id: 1, account_id: 12).and_return(Failure([:order_and_account_not_founded, {}]))
        subject
      end
    end

    context 'and account has invalid email address' do
      let(:command) { ->(*) { Failure([:invalid_account_email, { error: 'invalid_account_email' }]) } }

      it { expect(subject.status).to eq(422) }
      it { expect(subject.body.first).to eq({ error: 'invalid_account_email' }.to_json) }

      it 'calls command with right data' do
        expect(command).to receive(:call).with(order_id: 1, account_id: 12).and_return(Failure([:invalid_account_email, {}]))
        subject
      end
    end

    # other tests for failured command results
  end

  context 'with real dependencies' do
    let(:action) { described_class.new }

    # let(:session) { { account_id: Factory(:account).id } }
    # let(:env_params) { { 'rack.session' => session, id: Factory(:order_with_items).id } }

    it 'process success result correctly' do
      # test here
    end
  end
end
