module Hardware
  class Cpu

    def self.cpu_usage
      `grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}'`.to_f
    end

  end
end