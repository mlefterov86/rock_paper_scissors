# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GamesController do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #play' do
    let(:player_choice) { Game::RULES.keys.sample.to_s }
    let(:result) { %i[player computer tie].sample }
    let(:game) { Game.new(player_choice:) }

    before do
      allow(controller).to receive(:game).and_return(game)
      allow(game).to receive(:play).and_return(result)

      get :play, params: { id: player_choice }
    end

    it 'assigns @player_choice' do
      expect(assigns(:player_choice)).to eq(player_choice)
    end

    it 'assigns @result' do
      expect(result).to eq(assigns(:result))
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'renders correct template' do
      expect(response).to render_template(:play)
    end

    context 'when Game model is invalid' do
      let(:player_choice) { '' }

      before { allow(game).to receive(:valid?).and_return(false) }

      it 'assigns @result' do
        expect(assigns(:result)).to eq :invalid
      end
    end
  end
end
