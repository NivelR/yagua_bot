#!/usr/bin/env ruby

require 'telebot'
require 'pp'
require 'net/http' 
require_relative 'grapher' 

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
    msg = "Woff arf arf"
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
    client.send_message(chat_id: message.chat.id, text: "Enviaste una IP: #{message.text}. -woof")
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
    msg = "Dedicate a otra cosa... no te entiendo lo que decis... -woof"
    client.send_message(chat_id: message.chat.id, text: msg, reply_markup: markup)
  end
end

