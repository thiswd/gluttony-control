require 'json'

class DataImporter
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def import_from_file

    begin
      import_history = create_import_history
      products = read_file

      products.each do |product|
        begin
          mapped_data = ProductMapper.map(product)
          Product.create!(mapped_data)
          import_history.increment(:records_imported)
        rescue => e
          import_history.error_details ||= ""
          import_history.error_details += "Failed to import product #{product["code"]}: #{e.message}\n"
        ensure
          import_history.increment(:records_processed)
        end
      end

      import_history.status =
        if import_history.error_details.present?
          ImportHistory::FAILED
        else
          ImportHistory::COMPLETED
        end

    rescue => e
      import_history.status = ImportHistory::FAILED
      import_history.error_details = "Error: #{e.message}"
    end

    import_history.save!
  end

  private

  def read_file
    products = []
    File.foreach(file_path) do |line|
      products << JSON.parse(line)
    end
    products
  end

  def create_import_history
    ImportHistory.create!(filename: File.basename(file_path), status: ImportHistory::START, imported_at: Time.now)
  end
end
