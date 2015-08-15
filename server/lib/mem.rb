module Hardware
  class Mem

    def self.ram_usage
      used_ram * 100 / total_ram
    end

    def self.total_ram
      %x(cat /proc/meminfo | grep -i MemTotal | awk '{print $2}').to_i
    end

    def self.free_ram
      %x(cat /proc/meminfo | grep -i MemFree | awk '{print $2}').to_i
    end

    def self.used_ram
      total_ram - free_ram
    end
  
  end

end