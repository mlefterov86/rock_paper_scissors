# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameHelper do
  describe '#show_winner' do
    let(:result) { %i[player computer].sample }

    context 'when it is a tie' do
      let(:result) { :tie }

      it "returns 'It is tie!' for :tie result" do
        expect(show_winner(result)).to eq('It is tie!')
      end
    end

    it "returns '<Result> wins!' for non-tie result" do
      expect(show_winner(result)).to eq("#{result.capitalize} wins!")
    end
  end

  describe '#invalid?' do
    it 'returns true for :invalid result' do
      result = :invalid
      expect(invalid?(result)).to be true
    end

    it 'returns false for non-invalid result' do
      result = :player
      expect(invalid?(result)).to be false
    end
  end
end
