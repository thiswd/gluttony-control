require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    subject { build(:product) }

    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:imported_t) }

    it { should validate_uniqueness_of(:code).case_insensitive }

    it do
      should validate_inclusion_of(:status)
        .in_array(Product::STATUS)
    end
  end

  describe 'invalid scenarios' do
    let!(:existing_product) { create(:product, code: 12345678) }

    it 'does not allow duplicate code' do
      new_product = build(:product, code: existing_product.code)
      expect(new_product).not_to be_valid
      expect(new_product.errors[:code]).to include('has already been taken')
    end

    it 'does not allow invalid status' do
      product_with_invalid_status = build(:product, status: 'invalid_status')
      expect(product_with_invalid_status).not_to be_valid
      expect(product_with_invalid_status.errors[:status]).to include('is not included in the list')
    end
  end
end
