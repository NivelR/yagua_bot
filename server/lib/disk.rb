module Hardware
  class Disk

    def self.usage
      %x(df -h --total | grep total | awk '{print $5}').to_i
    end

    def self.free
      100 - usage
    end

  end
end