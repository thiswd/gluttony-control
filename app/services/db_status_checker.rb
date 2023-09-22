class DbStatusChecker
  def self.check
    if ActiveRecord::Base.connection.active?
      "Database connected"
    else
      "Database failed"
    end
  end
end
