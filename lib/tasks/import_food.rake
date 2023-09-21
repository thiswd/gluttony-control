require_relative 'helpers/downloader'
require_relative 'helpers/extractor'
require_relative 'helpers/file_names_fatcher'

namespace :import do
  task :open_food_facts, [:limit_records] => :environment do |_, args|

    LIMIT_DEFAULT = 100.freeze

    limit_records = args[:limit_records].to_i
    limit_records = LIMIT_DEFAULT if limit_records == 0

    BASE_URL = "https://challenges.coode.sh/food/data/json/".freeze

    filenames = FileNamesFetcher.fetch

    filenames.each do |filename|
      puts "Processing #{filename}"

      tmp_file_path = Rails.root.join('tmp', filename)
      json_file_path = Rails.root.join('tmp', filename.gsub('.gz', ''))

      Downloader.download(BASE_URL + filename, tmp_file_path)

      Extractor.extract(tmp_file_path, json_file_path, limit_records)

      importer = ProductImporter.new(json_file_path)
      importer.import_from_file

      File.delete(tmp_file_path)
      File.delete(json_file_path)

      puts "#{filename} processed!"
    end
  end
end
