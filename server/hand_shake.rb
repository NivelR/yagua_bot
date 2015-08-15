class HandShake < Cuba

	define do
	  on get do 
      res.headers.merge! "Content-Type" => "application/json"
	    res.write({mbaepa: 'pora'}.to_json)
	  end
  end

end	
