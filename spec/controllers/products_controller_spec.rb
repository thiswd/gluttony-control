require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  let(:api_key) { ApiKey.create! }

  before do
    request.headers["X-API-KEY"] = api_key.access_token
  end

  describe "GET #index" do
    let!(:products) { create_list(:product, 30) }

    context "with default pagination" do
      before { get :index }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns default per page count" do
        expect(JSON.parse(response.body)["pagination"]["per_page"]).to eq(25)
      end

      it "returns correct total pages" do
        expect(JSON.parse(response.body)["pagination"]["total_pages"]).to eq(2)
      end

      it "returns correct total entries" do
        expect(JSON.parse(response.body)["pagination"]["total_entries"]).to eq(30)
      end
    end

    context "with custom pagination params" do
      before { get :index, params: { page: 2, per_page: 20 } }

      it "returns correct current page" do
        expect(JSON.parse(response.body)["pagination"]["current_page"]).to eq(2)
      end

      it "returns provided per page count" do
        expect(JSON.parse(response.body)["pagination"]["per_page"]).to eq(20)
      end
    end

    context "when no products are present" do
      before do
        Product.delete_all
        get :index
      end

      it "returns zero total entries" do
        expect(JSON.parse(response.body)["pagination"]["total_entries"]).to eq(0)
      end
    end

    context "without valid API key" do
      before do
        request.headers["X-API-KEY"] = "invalid_key"
        get :index
      end

      it "returns unauthorized status" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET #show" do
    let!(:product) { create(:product) }

    context "when product exists" do
      before { get :show, params: { code: product.code } }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns the expected product" do
        expect(response.body).to include(product.code)
      end
    end

    context "when product does not exist" do
      before { get :show, params: { code: "nonexistent" } }

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns an error message" do
        expect(response.body).to include("Record not found")
      end
    end
  end
end
