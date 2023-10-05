# frozen_string_literal: true

class Game
  RULES = {
    rock: %i[scissors hammer],
    paper: %i[rock],
    scissors: %i[paper],
    hammer: %i[scissors paper]
  }.freeze

  include ActiveModel::Validations

  attr_reader :player_choice

  validates :player_choice, inclusion: { in: RULES.keys }

  def initialize(player_choice:)
    @player_choice = player_choice&.to_sym
  end

  def play
    winner.call
  end

  private

  def winner
    @winner ||= Winner.new(player_choice)
  end
end
