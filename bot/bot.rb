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

  case message.text
  when /start/
    msg = "Woff arf arf"
    client.send_message(chat_id: message.chat.id, text: msg, reply_markup: markup)
  
  when /agregar_server/
  	 msg = "Agregado, quedate piola #{message.text}. woof"
  	client.send_message(chat_id: message.chat.id, text: msg)
  	sleep 3
    client.send_chat_action(chat_id: message.chat.id, action: :typing)
    client.send_message(chat_id: message.chat.id, text: "Listo. woof")
  
  when /quien_es_trolo/
    msg = "Silvio llegó último a GitHub"
    client.send_message(chat_id: message.chat.id, text: msg, reply_markup: markup)
  
  else
    msg = "Dedicate a otra cosa... no te entiendo lo que decis... woof"
    client.send_message(chat_id: message.chat.id, text: msg, reply_markup: markup)
  end
end

