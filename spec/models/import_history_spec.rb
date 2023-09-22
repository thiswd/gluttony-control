require "rails_helper"

RSpec.describe ImportHistory, type: :model do
  describe "validations" do
    subject { build(:import_history) }

    it { should validate_presence_of(:imported_at) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:filename) }

    it do
      should validate_inclusion_of(:status)
        .in_array(ImportHistory::STATUS)
    end
  end

  describe "invalid scenarios" do
    it "does not allow invalid status" do
      import_history_with_invalid_status = build(:import_history, status: "invalid_status")
      expect(import_history_with_invalid_status).not_to be_valid
      expect(import_history_with_invalid_status.errors[:status]).to include("is not included in the list")
    end
  end
end
