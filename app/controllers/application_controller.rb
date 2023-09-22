class ApplicationController < ActionController::API

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

end
