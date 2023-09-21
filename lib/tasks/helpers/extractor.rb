require 'zlib'

class Extractor
  def self.extract(gz_file_path, destination, records_amount)
    raise "Source file #{gz_file_path} does not exist" unless File.exist?(gz_file_path)

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
  rescue Zlib::GzipFile::Error
    raise "The file #{gz_file_path} is not a valid gzip file or is corrupted"
  rescue IOError => e
    raise "An IO error occurred: #{e.message}"
  end
end
