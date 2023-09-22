require "open-uri"

class FileNamesFetcher
  INDEX_URL = "https://challenges.coode.sh/food/data/json/index.txt".freeze

  def self.fetch
    content = URI.open(INDEX_URL).read

    if content.empty?
      raise "Failed to fetch file names, response is empty."
    end

    content.split("\n")
  rescue OpenURI::HTTPError => e
    raise "An HTTP error occurred: #{e.message}"
  rescue Timeout::Error
    raise "Request to #{INDEX_URL} timed out."
  rescue StandardError => e
    raise "An error occurred while fetching file names: #{e.message}"
  end
end
