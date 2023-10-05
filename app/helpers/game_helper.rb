# frozen_string_literal: true

module GameHelper
  def show_result(result)
    return 'It is tie!' if result == :tie

    "#{result.capitalize} wins!"
  end

  def invalid?(result)
    result == :invalid
  end
end
