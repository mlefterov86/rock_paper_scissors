# frozen_string_literal: true

class LocalChoice
  def initialize(player_choice)
    @player_choice = player_choice
  end

  def call
    return Game::RULES.keys.sample if player_choice_hammer?

    Game::RULES.keys[0..2].sample
  end

  private

  attr_reader :player_choice

  def player_choice_hammer?
    player_choice == :hammer
  end
end
