require 'open-uri'

class Downloader
  def self.download(url, destination)
    File.open(destination, "wb") do |file|
      file.write URI.open(url).read
    end
  end
end
