FactoryBot.define do
  factory :product do
    code { Faker::Number.unique.between(from: 20_000_000, to: 99_999_999) }
    status { Product::STATUS.sample }
    imported_t { Time.now }
    url { Faker::Internet.url(host: 'openfoodfacts.org') }
    creator { Faker::Internet.username }
    created_t { Faker::Time.between(from: 10.years.ago, to: 1.year.ago).to_i }
    last_modified_t { Faker::Time.between(from: 1.year.ago, to: Time.now).to_i }
    product_name { Faker::Food.dish }
    quantity { "#{Faker::Number.between(from: 1, to: 500)} g" }
    brands { Faker::Company.name }
    categories { Faker::Food.ethnic_category }
    labels { Faker::Food.description }
    cities { Faker::Address.city }
    purchase_places { "#{Faker::Address.city},#{Faker::Address.country}" }
    stores { Faker::Company.name }
    ingredients_text { Faker::Food.ingredient }
    traces { Faker::Food.spice }
    serving_size { "#{Faker::Food.measurement} g" }
    serving_quantity { Faker::Number.decimal(l_digits: 2) }
    nutriscore_score { Faker::Number.between(from: 1, to: 40) }
    nutriscore_grade { %w[a b c d e].sample }
    main_category { Faker::Food.fruits }
    image_url { Faker::LoremFlickr.image(size: "400x400", search_terms: ['food']) }
  end
end
