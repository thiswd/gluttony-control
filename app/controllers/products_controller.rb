class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 25
    @products = Product.page(page).per(per_page)

    render json: {
      pagination: {
        current_page: @products.current_page,
        per_page: @products.limit_value,
        total_pages: @products.total_pages,
        total_entries: @products.total_count
      },
      data: serialized_products
    }
  end

  def show
    render json: @product, serializer: ProductSerializer, view_context:
  end

  def update
    if @product.update(product_params)
      render(json: @product, serializer: ProductSerializer, view_context:)
    else
      render json: {
        error: "Product update failed: #{@product.errors.full_messages.to_sentence}"
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @product.update!(status: Product::TRASH)
    render json: { message: "Product marked as #{Product::TRASH}" }
  end

  private

    def product_params
      params.require(:product).permit(
        :url,
        :creator,
        :product_name,
        :quantity,
        :brands,
        :categories,
        :labels,
        :cities,
        :purchase_places,
        :stores,
        :ingredients_text,
        :traces,
        :serving_size,
        :serving_quantity,
        :nutriscore_score,
        :nutriscore_grade,
        :main_category,
        :image_url
      )
    end

    def set_product
      @product = Product.find_by!(code: params[:code])
    end

    def serialized_products
      ActiveModel::SerializableResource.new(
        @products,
        each_serializer: ProductSerializer,
        view_context:
      ).as_json
    end
end
