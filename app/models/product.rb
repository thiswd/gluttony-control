class Product < ApplicationRecord

  before_create :set_status_and_timestamp

  PUBLISHED = "published".freeze
  DRAFT = "draft".freeze
  TRASH = "trash".freeze
  STATUS = [PUBLISHED, DRAFT, TRASH].freeze

  validates :code, presence: true
  validates :code, uniqueness: true
  validates :status, inclusion: { in: STATUS }, allow_nil: true

  def set_status_and_timestamp
    self.status = PUBLISHED
    self.imported_t = Time.now
  end
end
