class Yaguabot < Cuba
  Cuba.define do
    on get, default do
      res.write ({
        "status": 
          {
            "ram": "",
            "cpu": "",
            "disk": ""
          }
      }).to_json
    end
  end

  private
    def ram_usage
    end

    def cpu_usage
    end

    def disk_usage
    end
end