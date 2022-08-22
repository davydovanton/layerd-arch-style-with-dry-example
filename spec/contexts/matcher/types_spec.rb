# frozen_string_literal: true

RSpec.describe Matcher::Types do
  describe 'AccountCharacteristic' do
    let(:type) { Matcher::Types::AccountCharacteristic }

    context 'when account characteristic is correct' do
      it { expect(type['characteristic of account']).to eq('characteristic of account') }
    end

    context 'when account characteristic is less than 10 chars' do
      it { expect { type['less 10'] }.to raise_error(Dry::Types::ConstraintError) }
    end
  end

  describe 'CatToyTitle' do
    let(:type) { Matcher::Types::CatToyTitle }

    context 'when cat toy title is correct' do
      it { expect(type['Name of toy']).to eq('Name of toy') }
    end

    context 'when cat toy title is less than 3 chars' do
      it { expect { type['X'] }.to raise_error(Dry::Types::ConstraintError) }
    end
  end

  describe 'CatToyArchivedStatus' do
    let(:type) { Matcher::Types::CatToyArchivedStatus }

    [
      [nil, false],

      [1, true],
      [0, false],

      [true, true],
      [false, false],

      ['0', false],
      ['1', false]
    ].each do |value, result|
      it { expect(type[value]).to eq(result) }
    end
  end
end
