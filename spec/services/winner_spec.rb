# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Winner do
  subject(:winner) { described_class.new(:rock) }

  describe '#call' do
    it 'returns :player' do
      allow(winner).to receive(:computer_choice).and_return(:scissors)
      allow(winner).to receive(:player_choice).and_return(:rock)
      expect(winner.call).to eq :player
    end

    it 'returns :computer' do
      allow(winner).to receive(:player_choice).and_return(:scissors)
      allow(winner).to receive(:computer_choice).and_return(:rock)
      expect(winner.call).to eq :computer
    end

    it 'returns :tie' do
      allow(winner).to receive(:player_choice).and_return(:rock)
      allow(winner).to receive(:computer_choice).and_return(:rock)
      expect(winner.call).to eq :tie
    end
  end

  describe '#computer_choice' do
    it 'returns a valid choice' do
      allow(winner).to receive(:remote_result).and_return(:scissors)
      expect(winner.send(:computer_choice)).to(satisfy { |choice| Game::RULES.keys.include?(choice) })
    end
  end
end
