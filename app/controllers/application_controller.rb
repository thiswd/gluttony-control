class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def status
    db_status = DbStatusChecker.check
    last_cron_run = ImportHistory.last.formatted_imported_at
    uptime = SystemStatusChecker.uptime
    memory_usage = SystemStatusChecker.formatted_memory_usage

    render json: {
      db_status:,
      last_cron_run:,
      uptime:,
      memory_usage:
    }
  end

  private

  def record_not_found
    render json: { error: "Record not found" }, status: :not_found
  end
end
