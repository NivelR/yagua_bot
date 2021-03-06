#!/usr/bin/env ruby
require 'telebot'
require 'pp'
require 'net/http' 
require_relative 'grapher' 
require_relative '../utils.rb'
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
      [ "agregar_server" ]
    ]
  )

  #if message.text =~ /^(\d+\.\d+\.\d+.\d+)/;
  # client.send_chat_action(chat_id: message.chat.id, action: :typing)
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

    when Utils::Addresses.valid_ipv4
      client.send_chat_action(chat_id: message.chat.id, action: :typing)
      client.send_message(chat_id: message.chat.id, text: "Enviaste una IP a: #{message.text}. -woof")
      @ip = message.text
      server_id = Server.all.count.to_s(16)
      @server = Server.new(:server_id => server_id, :name => message.text, :ip => message.text, :port => 9999)
      @server.save
      client.send_chat_action(chat_id: message.chat.id, action: :typing)
      client.send_message(chat_id: message.chat.id, text: "Decime el puerto: /port 9393 -woof")

    when Utils::Addresses.valid_port
      @port = message.text[6..-1]
      if /^(\d{4})$/
         client.send_chat_action(chat_id: message.chat.id, action: :typing)
         client.send_message(chat_id: message.chat.id, text: "Error puerto incorrecto. Enviaste: #{@port}. -woof")    
        return false 
      end

      client.send_chat_action(chat_id: message.chat.id, action: :typing)
      client.send_message(chat_id: message.chat.id, text: "Enviaste el Puerto: #{@port}. -woof") 
      client.send_chat_action(chat_id: message.chat.id, action: :typing)
      if @ip
        uri = URI("http://#{@ip}:#{@port}/status")
        msg = Net::HTTP.get(uri) # => String

        msg = JSON.parse(msg)
        
        pic = Grapher::Grapher.new(msg["status"].merge({title: "Server Name - #{@ip}"}))

        file = Telebot::InputFile.new("#{pic.path}", 'image/png')
        
        client.send_photo(chat_id: message.chat.id, photo: file)
      else
        client.send_message(chat_id: message.chat.id, text: "Decime la IP -woof")
      end

    else
      msg = "grrrrrrrrrrr... no te entiendo lo que decis... chaque el perro -woof"
      client.send_message(chat_id: message.chat.id, text: msg, reply_markup: markup)
    end
end
