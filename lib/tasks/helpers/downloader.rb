require_relative "base_http_service"

class Downloader < BaseHttpService
  def self.download(url, destination)
    content = fetch_content(URI(url))
    File.binwrite(destination, content)
  end
end
