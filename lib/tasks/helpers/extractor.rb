require 'zlib'

class Extractor
  def self.extract(gz_file_path, destination)
    Zlib::GzipReader.open(gz_file_path) do |gz|
      File.open(destination, "wb") do |file|
        file.write(gz.read)
      end
    end
  end
end
