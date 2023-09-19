class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.integer :code, limit: 8, null: false, index: { unique: true }
      t.string :status
      t.datetime :imported_t
      t.string :url
      t.string :creator
      t.integer :created_t
      t.integer :last_modified_t
      t.string :product_name
      t.string :quantity
      t.string :brands
      t.text :categories
      t.text :labels
      t.string :cities
      t.string :purchase_places
      t.string :stores
      t.text :ingredients_text
      t.text :traces
      t.string :serving_size
      t.decimal :serving_quantity, precision: 10, scale: 2
      t.integer :nutriscore_score
      t.string :nutriscore_grade
      t.string :main_category
      t.string :image_url

      t.timestamps
    end
  end
end
