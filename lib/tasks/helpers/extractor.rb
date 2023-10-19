require "zlib"

class Extractor
  def self.extract(gz_file_path, destination, records_amount)
    validate_file(gz_file_path)
    extract_content(gz_file_path, destination, records_amount)
  rescue => e
    handle_error(e, gz_file_path)
  end

  private

    def self.validate_file(gz_file_path)
      raise "Source file #{gz_file_path} does not exist" unless File.exist?(gz_file_path)
    end

    def self.extract_content(gz_file_path, destination, records_amount)
      Zlib::GzipReader.open(gz_file_path) do |gz|
        File.open(destination, "wb") do |file|
          records_amount.times do
            begin
              line = gz.readline
              file.write(line)
            rescue EOFError
              break
            end
          end
        end
      end
    end

    def self.handle_error(e, gz_file_path)
      case e
      when Zlib::GzipFile::Error
        raise "The file #{gz_file_path} is not a valid gzip file or is corrupted"
      when IOError
        raise "An IO error occurred: #{e.message}"
      else
        raise "An unknown error occurred: #{e.message}"
      end
    end
end
