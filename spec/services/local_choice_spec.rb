# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LocalChoice do
  describe '#call' do
    subject(:call) { described_class.new(player_choice).call }

    context "when player choice is 'hammer'" do
      let(:player_choice) { :hammer }

      it 'returns a random choice from the complete set of choices' do
        expect(Game::RULES.keys).to include(call)
      end
    end

    context "when player choice is not 'hammer'" do
      let(:player_choice) { :rock }

      it 'returns a random choice from the first three choices' do
        expect(Game::RULES.keys[0..2]).to include(call)
      end
    end
  end
end
