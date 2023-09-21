require 'zlib'

class Extractor
  def self.extract(gz_file_path, destination, records_amount)
    Zlib::GzipReader.open(gz_file_path) do |gz|
      File.open(destination, "wb") do |file|
        records_amount.times do
          line = gz.readline
          file.write(line)
        rescue EOFError
          break
        end
      end
    end
  end
end
