class Product < ApplicationRecord
  before_create :set_default_status_and_timestamp

  PUBLISHED = "published".freeze
  DRAFT = "draft".freeze
  TRASH = "trash".freeze
  STATUS = [PUBLISHED, DRAFT, TRASH].freeze

  validates :code, presence: true
  validates :code, uniqueness: true
  validates :status, inclusion: { in: STATUS }, allow_nil: true

  private

    def set_default_status_and_timestamp
      self.status = PUBLISHED
      self.imported_t = Time.zone.now
    end
end
