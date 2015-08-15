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
  reply = "You've said: #{message.text} "
  client.send_message(chat_id: message.chat.id, text: reply)
end