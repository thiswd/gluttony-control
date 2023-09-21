class CreateImportHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :import_histories do |t|
      t.datetime :imported_at, null: false
      t.string :filename, null: false
      t.string :status, null: false
      t.integer :records_processed, default: 0
      t.integer :records_imported, default: 0
      t.text :error_details
      t.timestamps
    end
  end
end
