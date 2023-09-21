require 'open-uri'

class Downloader
  def self.download(url, destination)
    File.open(destination, "wb") do |file|
      file.write URI.open(url).read
    end
  rescue OpenURI::HTTPError => e
    raise "An HTTP error occurred: #{e.message}"
  rescue Timeout::Error
    raise "Request to #{url} timed out."
  rescue StandardError => e
    raise "An error occurred while downloading from #{url}: #{e.message}"
  end
end
