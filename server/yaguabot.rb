class Yaguabot < Cuba
  define do
    on get, default do
      res.write ({
        status: 
          {
            ram: ram_usage,
            cpu: cpu_usage,
            disk: disk_usage
          }
      }.to_json)
    end
  end

  private
    def ram_usage
      total_ram = %x(cat /proc/meminfo | grep -i MemTotal | awk '{print $2}').to_i
    end

    def cpu_usage
    end

    def disk_usage
    end
end