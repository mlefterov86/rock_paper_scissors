# frozen_string_literal: true

# spec/models/game_spec.rb
require 'rails_helper'

RSpec.describe Game do
  let(:game) { described_class.new(player_choice: :rock) }

  describe '#initialize' do
    context 'with a valid player choice' do
      it 'initializes successfully' do
        expect(game).to be_valid
      end
    end

    context 'with a nil player choice' do
      it 'initializes with a nil player choice' do
        game = described_class.new(player_choice: nil)
        expect(game.player_choice).to be_nil
      end
    end

    context 'with an invalid player choice' do
      it 'initializes with an invalid player choice' do
        expect(described_class.new(player_choice: :invalid_choice)).not_to be_valid
      end
    end
  end

  describe 'validations' do
    context 'when validates player_choice' do
      context 'when valid' do
        it { expect(described_class.new(player_choice: 'rock')).to be_valid }
      end

      context 'when invalid' do
        context 'when player_choice is `nil`' do
          it { expect(described_class.new(player_choice: nil)).to be_invalid }
        end

        context 'when player_choice is empty string' do
          it { expect(described_class.new(player_choice: '')).to be_invalid }
        end

        context 'when player_choice is something not included into the list' do
          it { expect(described_class.new(player_choice: 'something')).to be_invalid }
        end
      end
    end
  end

  describe '#play' do
    it 'returns :player when player wins' do
      allow(game).to receive(:computer_choice).and_return(:scissors)
      expect(game.play).to eq(:player)
    end

    it 'returns :computer when computer wins' do
      allow(game).to receive(:computer_choice).and_return(:paper)
      expect(game.play).to eq(:computer)
    end

    it "returns :tie when it's a tie" do
      allow(game).to receive(:computer_choice).and_return(:rock)
      expect(game.play).to eq(:tie)
    end
  end

  describe '#winner' do
    it 'returns :player' do
      allow(game).to receive(:player_wins?).and_return(true)
      expect(game.send(:winner)).to eq :player
    end

    it 'returns :computer' do
      allow(game).to receive(:player_wins?).and_return(false)
      allow(game).to receive(:computer_wins?).and_return(true)
      expect(game.send(:winner)).to eq :computer
    end

    it 'returns :tie' do
      allow(game).to receive(:player_wins?).and_return(false)
      allow(game).to receive(:computer_wins?).and_return(false)
      expect(game.send(:winner)).to eq :tie
    end
  end

  describe '#computer_choice' do
    it 'returns a valid choice' do
      allow(game).to receive(:remote_result).and_return(:scissors)
      expect(game.send(:computer_choice)).to(satisfy { |choice| described_class::RULES.keys.include?(choice) })
    end
  end
end
