class Yaguabot < Cuba
  define do
    on get, default do
      res.write ({
        status: 
          {
            ram: Hardware::Mem.usage,
            cpu: Hardware::Cpu.usage,
            disk: Hardware::Disk.usage
          }
      }.to_json)
    end
  end

  
end