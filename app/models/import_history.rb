class ImportHistory < ApplicationRecord
  START = "started".freeze
  COMPLETED = "completed".freeze
  FAILED = "failed".freeze
  STATUS = [START, COMPLETED, FAILED].freeze

  validates :imported_at, :filename, :status, presence: true
  validates :status, inclusion: { in: STATUS }

  def formatted_imported_at
    imported_at.strftime("%m/%d/%Y %I:%M%p")
  end
end
