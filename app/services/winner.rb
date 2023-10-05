# frozen_string_literal: true

class Winner
  attr_reader :player_choice

  def initialize(player_choice)
    @player_choice = player_choice
  end

  def call
    Rails.logger.info("### Player choice `#{player_choice}`")
    Rails.logger.info("### Computer choice `#{computer_choice}`")

    return :player if player_wins?
    return :computer if computer_wins?

    :tie
  end

  private

  def player_wins?
    Game::RULES[player_choice].include?(computer_choice)
  end

  def computer_wins?
    Game::RULES[computer_choice].include?(player_choice)
  end

  # requests `https://5eddt4q9dk.execute-api.us-east-1.amazonaws.com/rps-stage/throw`
  # from https://curbrockpaperscissors.docs.apiary.io/#reference/0/throws/retrieve-throw
  # which always returns 500  ¯\(ツ)/¯
  # If provided API does not return result it fallbacks to generate it locally
  def computer_choice
    # fallback to local throw, since remote API does not provide a 'hammer' throw option
    return @computer_choice ||= local_result if player_choice == 'hammer'

    @computer_choice ||= remote_result || local_result
  end

  def remote_result
    @remote_result ||= RemoteChoice.new.call
  end

  def local_result
    @local_result ||= LocalChoice.new(player_choice).call
  end
end
