class ImportHistory < ApplicationRecord

  START = "started".freeze
  COMPLETED = "completed".freeze
  FAILED = "failed".freeze
  STATUS = [START, COMPLETED, FAILED].freeze

  validates :imported_at, :filename, :status, presence: true
  validates :status, inclusion: { in: STATUS }

end
