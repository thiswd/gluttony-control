require_relative "base_http_service"

class FileNamesFetcher < BaseHttpService
  INDEX_URL = URI("https://challenges.coode.sh/food/data/json/index.txt")

  def self.fetch
    content = fetch_content(INDEX_URL)

    if content.empty?
      raise "Failed to fetch file names, response is empty."
    end

    content.split("\n")
  end
end
