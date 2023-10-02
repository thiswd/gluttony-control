class ApiKey < ApplicationRecord
  before_create :set_access_token

  private

    def set_access_token
      self.access_token = new_access_token
    end

    def new_access_token
      SecureRandom.hex(20)
    end
end
