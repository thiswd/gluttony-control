class ProductMapper
  class << self
    def map(data)
      {
        code: sanitize_code(data["code"]),
        url: data["url"],
        creator: data["creator"],
        created_t: to_integer(data["created_t"]),
        last_modified_t: to_integer(data["last_modified_t"]),
        product_name: data["product_name"],
        quantity: data["quantity"],
        brands: data["brands"],
        categories: data["categories"],
        labels: data["labels"],
        cities: data["cities"],
        purchase_places: data["purchase_places"],
        stores: data["stores"],
        ingredients_text: data["ingredients_text"],
        traces: data["traces"],
        serving_size: data["serving_size"],
        serving_quantity: to_decimal(data["serving_quantity"]),
        nutriscore_score: to_integer(data["nutriscore_score"]),
        nutriscore_grade: data["nutriscore_grade"],
        main_category: data["main_category"],
        image_url: data["image_url"]
      }
    end

    private

    def sanitize_code(code)
      code.to_s.strip.gsub(/\D/, "")
    end

    def to_integer(value)
      value.to_i
    end

    def to_decimal(value)
      value.to_d
    end
  end
end
