# frozen_string_literal: true

class GamesController < ApplicationController
  def index; end

  def play
    @player_choice = player_choice
    @winner = game.valid? ? game.play : :invalid
  end

  private

  def game
    @game ||= Game.new(player_choice:)
  end

  def player_choice
    params[:id]
  end
end
