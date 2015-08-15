class HandShake < Cuba

	define do
	  on get do 
	    res.write({mbaepa: 'pora'}.to_json)
	  end
  end

end	
