class Product < ApplicationRecord

  STATUS = %w[published draft archived]

  validates :code, :status, :imported_t, presence: true
  validates :code, uniqueness: true
  validates :status, inclusion: { in: STATUS }

end
