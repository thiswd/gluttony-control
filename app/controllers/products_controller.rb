class ProductsController < ApplicationController
  ProductsController < ApplicationController

  before_action :set_product, only: [:show, :update, :destroy]

  def index
    @products = Product.all

    if @products.any?
      render json: @products
    else
      render json: { error: "No products found" }, status: :not_found
    end
  end

  def show
    if @product
      render json: @product
    else
      render json: { error: "Product not found" }, status: :not_found
    end
  end

  def update
    if @product && @product.update(product_params)
      render json: @product
    else
      render json: { error: "Product update failed" }, status: :unprocessable_entity
    end
  end

  def destroy
    if @product
      @product.update(status: Product::ARCHIVED)
      render json: { message: "Product marked as #{Product::ARCHIVED}" }
    else
      render json: { error: "Product not found" }, status: :not_found
    end
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
    @product ||= Product.find_by(code: params[:code])
  end
end
