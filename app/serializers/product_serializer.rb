class ProductSerializer < ActiveModel::Serializer
  attributes :id, :code, :status, :imported_t, :url, :creator, :created_t, :last_modified_t, :product_name, :quantity, :brands, :categories, :labels, :cities, :purchase_places, :stores, :ingredients_text, :traces, :serving_size, :serving_quantity, :nutriscore_score, :nutriscore_grade, :main_category, :image_url

  attribute :links do
    {
      self: instance_options[:view_context].product_url(object.code),
      update: instance_options[:view_context].product_url(object.code),
      destroy: instance_options[:view_context].product_url(object.code)
    }
  end
end
