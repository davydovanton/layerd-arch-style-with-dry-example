# frozen_string_literal: true

RSpec.describe Matcher::Entities::CatToy, type: :entity do
  let(:toy) { described_class.new(payload) }

  let(:payload) do
    {
      id: 1,
      title: 'Title for cat toy',
      characteristic: 132514
    }
  end

  it { expect(toy.id).to eq(1) }

  describe '#archived?' do
    subject { toy.archived? }

    let(:payload) do
      {
        id: 1,
        title: 'Title for cat toy',
        characteristic: 132514,
        archived: archived_status
      }
    end

    context 'when archived status of toy is "0" integer' do
      let(:archived_status) { 0 }

      it { expect(subject).to eq(false) }
    end

    context 'when archived status of toy is "false"' do
      let(:archived_status) { false }

      it { expect(subject).to eq(false) }
    end

    context 'when archived status of toy is "1" integer' do
      let(:archived_status) { 1 }

      it { expect(subject).to eq(true) }
    end

    context 'when archived status of toy is "true"' do
      let(:archived_status) { true }

      it { expect(subject).to eq(true) }
    end
  end
end
