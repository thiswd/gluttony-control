require "net/http"

class BaseHttpService
  def self.fetch_content(uri)
    response = Net::HTTP.get_response(uri)

    raise "Failed to fetch from #{uri}" unless response.is_a?(Net::HTTPSuccess)

    response.body
  rescue Net::HTTPClientError, Net::HTTPServerError => e
    raise "An HTTP error occurred: #{e.message}"
  rescue Net::OpenTimeout
    raise "Network open timeout for #{uri}."
  rescue Timeout::Error
    raise "Request to #{uri} timed out."
  rescue StandardError => e
    raise "An error occurred while fetching from #{uri}: #{e.message}"
  end
end
