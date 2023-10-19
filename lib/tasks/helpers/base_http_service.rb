require "net/http"

class BaseHttpService
  def self.fetch_content(uri)
    response = Net::HTTP.get_response(uri)
    validate_response(response, uri)
    response.body
  rescue => e
    handle_error(e, uri)
  end

  private

    def self.validate_response(response, uri)
      raise "Failed to fetch from #{uri}" unless response.is_a?(Net::HTTPSuccess)
    end

    def self.handle_error(e, uri)
      case e
      when Net::HTTPClientError, Net::HTTPServerError
        raise "An HTTP error occurred: #{e.message}"
      when Net::OpenTimeout
        raise "Network open timeout for #{uri}."
      when Timeout::Error
        raise "Request to #{uri} timed out."
      else
        raise "An error occurred while fetching from #{uri}: #{e.message}"
      end
    end
end
