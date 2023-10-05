# frozen_string_literal: true

module GameHelper
  def show_winner(winner)
    return 'It is tie!' if winner.to_sym == :tie

    "#{winner.capitalize} wins!"
  end

  def invalid?(winner)
    winner == :invalid
  end
end
