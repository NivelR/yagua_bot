#!/usr/bin/env ruby
require 'telebot'
require 'pp'
require 'net/http'
require 'mongo_mapper'
require_relative 'grapher'

Dir['../model/**/*.rb'].sort.each          { |rb| require rb }


MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "yagua_bot"

token =
  if ENV['TOKEN']
  	ENV['TOKEN']
  else
    abort "Configure el TOKEN en su entorno"
  end

bot = Telebot::Bot.new(token)

bot.run do |client, message|
  markup = Telebot::ReplyKeyboardMarkup.new(
    keyboard: [
      [ "agregar_server", "quien_es_trolo"],
      [ "N/C", "NN" ]
    ]
  )

  #if message.text =~ /^(\d+\.\d+\.\d+.\d+)/;
  #	client.send_chat_action(chat_id: message.chat.id, action: :typing)
  # client.send_message(chat_id: message.chat.id, text: "Enviaste una IP. woof")
  #end

  case message.text
	  when /start/
	    msg = "Bienvenido a Yagua Bot Woff arf arf"
	    client.send_message(chat_id: message.chat.id, text: msg, reply_markup: markup)
	  
	  when /agregar_server/
	  	client.send_chat_action(chat_id: message.chat.id, action: :typing)
	  	client.send_message(chat_id: message.chat.id, text: "Decime la IP:. -woof")
	    sleep 1  	    
	  
	  when /quien_es_trolo/
	    msg = "Silvio llegó último a GitHub"
	    client.send_message(chat_id: message.chat.id, text: msg, reply_markup: markup)

	  when /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/
	  	client.send_chat_action(chat_id: message.chat.id, action: :typing)
	    client.send_message(chat_id: message.chat.id, text: "Enviaste una IP a: #{message.text}. -woof")
	    @ip = message.text
      server_id = Server.all.count.to_s(16)
      @server = Server.new(:server_id => server_id, :name => message.text, :ip => message.text, :port => 9999)
      @server.save
	  	client.send_chat_action(chat_id: message.chat.id, action: :typing)
	  	client.send_message(chat_id: message.chat.id, text: "Decime el puerto: /port 9393 -woof")

	  when /port \d\d\d\d/
	  	@port = message.text[6..-1]
	  	client.send_chat_action(chat_id: message.chat.id, action: :typing)
	    client.send_message(chat_id: message.chat.id, text: "Enviaste el Puerto: #{@port}. -woof") 
	    client.send_chat_action(chat_id: message.chat.id, action: :typing)
		  uri = URI("http://#{@ip}:#{@port}/status")
		  msg = Net::HTTP.get(uri) # => String
		client.send_message(chat_id: message.chat.id, text: "Respuesta: #{msg}. -woof")

	  when /DHH/
	   	client.send_chat_action(chat_id: message.chat.id, action: :typing)
	   	uri = URI('http://192.168.0.107:9393/status')
		msg = Net::HTTP.get(uri) # => String
		client.send_message(chat_id: message.chat.id, text: "Respuesta: #{msg}. -woof")

	  when /NN/
	 	client.send_message(chat_id: message.chat.id, text: "Natalia Natalia -woof")
	  when /N\/C/
	 	client.send_message(chat_id: message.chat.id, text: "No sabe, no contesta. -woof")
	  else
	    msg = "grrrrrrrrrrr... no te entiendo lo que decis... chaque el perro -woof"
	    client.send_message(chat_id: message.chat.id, text: msg, reply_markup: markup)
	  end
end
