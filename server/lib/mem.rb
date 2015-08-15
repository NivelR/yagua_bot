module Hardware
  class Mem

    def self.usage
      used * 100 / total
    end

    def self.total
      %x(cat /proc/meminfo | grep -i MemTotal | awk '{print $2}').to_i
    end

    def self.free
      %x(cat /proc/meminfo | grep -i MemFree | awk '{print $2}').to_i
    end

    def self.used
      total - free
    end
  
  end

end