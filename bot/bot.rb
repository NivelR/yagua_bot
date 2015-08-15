#!/usr/bin/env ruby

require 'telebot'
require 'pp'

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
      [ "a", "b" ],
      [ "d", "e"],
      [ "g", "h"]
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
  when /^(\d+\.\d+\.\d+.\d+)/
  	client.send_chat_action(chat_id: message.chat.id, action: :typing)
    client.send_message(chat_id: message.chat.id, text: "Enviaste una IP: #{message.text}. -woof")

  else
    msg = "Dedicate a otra cosa... no te entiendo lo que decis... -woof"
    client.send_message(chat_id: message.chat.id, text: msg, reply_markup: markup)
  end
end

