# frozen_string_literal: true

RSpec.describe Matcher::Commands::SelectCatToysForOrder, type: :command do
  subject { command.call({ account_id: account_id, order: order }) }

  let(:command) { described_class.new(account_repo: account_repo, nda_matcher_logic: nda_matcher_logic) }

  let(:account_id) { 1 }
  let(:order) {
    {
      status: 'payed',
      items: [
        { title: 'Title #1', count: 1 },
        { title: 'Title #2', count: 3 },
        { title: 'Title #3', count: 2 }
      ]
    }
  }

  let(:account_repo) { instance_double('Matcher::Repositories::Account', find: account) }
  let(:account) { Matcher::Entities::Account.new(id: 1, characteristic: 'asdasdasdasda') }

  let(:nda_matcher_logic) { Matcher::Libs::NdaMatcherLogic.new }

  context 'when everything is okay' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq(selected_toys: []) }
  end

  context 'when order schema invalid' do
    let(:order) {
      {
        status: 'open',
        items: [{ title: 'Title #1', count: 1 }]
      }
    }

    it { expect(subject).to be_failure }
    it do
      expect(subject.failure).to eq(
        [:invalid_order, { error_message: { status: ['must be equal to payed'] }, original_order: order }]
      )
    end
  end

  context 'when account not found' do
    let(:account) { nil }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq([:account_not_founded, { account_id: 1, account: nil }]) }
  end

  context 'when nda matcher logic returns invalid result' do
    let(:nda_matcher_logic) { ->(*) { Failure([:error_message_in_nda_logic, { error: 'something' }]) } }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq([:error_message_in_nda_logic, { error: 'something' }]) }
  end

  context 'with real dependencies' do
    let(:command) { described_class.new }

    # I'm too lazy to make it real, sorry
    xit { expect(subject).to be_success }
  end
end
