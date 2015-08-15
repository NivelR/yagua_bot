class Server
	include MongoMapper::Document

	key :name, String
	key :ip, String
	key :puerto, Integer

	#set_collection_name "MP"
end