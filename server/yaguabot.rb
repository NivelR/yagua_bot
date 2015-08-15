class Yaguabot < Cuba
  define do
    on get, default do
      res.write ({
        status: 
          {
            ram: Hardware::Mem.ram_usage,
            cpu: Hardware::Cpu.cpu_usage,
            disk: 0
          }
      }.to_json)
    end
  end

  
end