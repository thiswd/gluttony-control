class SystemStatusChecker
  class << self
    def uptime
      uptime_seconds = (Time.now - $START_TIME)
      Time.at(uptime_seconds).strftime("%H:%M:%S")
    end

    def formatted_memory_usage
      "#{ActiveSupport::NumberHelper.number_to_delimited(memory_usage)} KB"
    end

    private

      def memory_usage
        process_info = Sys::ProcTable.ps.select { |proc| proc.pid == Process.pid }.first
        process_info.rss
      end
  end
end
