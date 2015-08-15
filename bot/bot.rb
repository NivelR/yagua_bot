#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require 'telebot'
require 'pp'

token =
  if File.exist?(TOKEN_FILE)
    File.read(TOKEN_FILE).strip
  elsif ENV['TOKEN']
    ENV['TOKEN']
  else
    abort "Please set token as TOKEN env variable"
  end

bot = Telebot::Bot.new(token)