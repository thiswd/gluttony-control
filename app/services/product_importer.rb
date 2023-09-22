require "json"

class ProductImporter
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def import_from_file
    ActiveRecord::Base.transaction do
      import_history = create_import_history

      each_product_in_file do |product|
        process_product(product, import_history)
      end

      finalize_import_history(import_history)
    end
  end

  private

    def each_product_in_file
      File.foreach(file_path) do |line|
        yield JSON.parse(line)
      end
    end

    def process_product(product, import_history)
      mapped_data = ProductMapper.map(product)
      Product.create!(mapped_data)
      import_history.increment(:records_imported)
    rescue => e
      import_history.error_details ||= ""
      import_history.error_details += "Failed to import product #{product["code"]}: #{e.message}\n"
    ensure
      import_history.increment(:records_processed)
    end

    def finalize_import_history(import_history)
      import_history.status =
        if import_history.error_details.present?
          ImportHistory::FAILED
        else
          ImportHistory::COMPLETED
        end
      import_history.save!
    end

    def create_import_history
      ImportHistory.create!(filename: File.basename(file_path), status: ImportHistory::START, imported_at: Time.zone.now)
    end
end
