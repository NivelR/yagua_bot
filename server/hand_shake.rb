class HandShake < Cuba

	Cuba.define do
	  on get, default do 
	    res.write({mbaepa: 'pora'}.to_json)
	  end
  end

end	
