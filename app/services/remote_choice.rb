# frozen_string_literal: true

require 'net/http'

class RemoteChoice
  CURB_PRODUCTION_RPS_URL = 'https://5eddt4q9dk.execute-api.us-east-1.amazonaws.com/rps-stage/throw'
  CURB_MOCK_RPS_URL = 'https://private-anon-4b42eef306-curbrockpaperscissors.apiary-mock.com/rps-stage/throw'

  def call
    return unless success?

    JSON.parse(response.body)['body'].to_sym
  end

  def success?
    response&.is_a?(Net::HTTPSuccess)
  end

  private

  def response
    @response ||=
      begin
        Net::HTTP.get_response(uri)
      rescue SocketError, Net::HTTPError => e
        Rails.logger.error("Error calling `#{uri}`: #{e}")
        false
      end
  end

  def uri
    URI(api_url)
  end

  # for some reason requesting production API url always returns 500 ¯\(ツ)/¯
  # mock API url returns always success result and throws `rock`
  def api_url
    [CURB_PRODUCTION_RPS_URL, CURB_MOCK_RPS_URL].sample
  end
end
