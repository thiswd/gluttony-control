class SystemStatusChecker
  class << self
    def uptime
      uptime_seconds = (Time.now - $START_TIME).to_i

      hours = uptime_seconds / 3600
      minutes = (uptime_seconds / 60) % 60
      seconds = uptime_seconds % 60

      "#{add_zero(hours)}:#{add_zero(minutes)}:#{add_zero(seconds)}"
    end

    def formatted_memory_usage
      "#{ActiveSupport::NumberHelper.number_to_delimited(memory_usage)} KB"
    end

    private

      def memory_usage
        process_info = Sys::ProcTable.ps.select { |proc| proc.pid == Process.pid }.first
        process_info.rss
      end

      def add_zero(number)
        number.to_s.rjust(2, "0")
      end
  end
end
