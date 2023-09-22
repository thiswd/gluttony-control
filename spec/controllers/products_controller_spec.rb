require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  describe "GET #index" do
    before { get :index }

    it "returns http success" do
      expect(response).to have_http_status(:success)
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
