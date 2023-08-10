# frozen_string_literal: true

require "dotenv"
Dotenv.load(".env.local", ".env")

require "discordrb"

require_relative "rb_bot_research/version"
require_relative "cincy_rbot/coin_flipper"

module RbBotResearch
  class Error < StandardError; end
  # Your code goes here...
end

module CincyRbot
  class Error < StandardError; end

  def self.run!
    srand # seed the randomizer
    bot = Discordrb::Bot.new token: ENV.fetch("DISCORD_BOT_TOKEN")

    # puts "This bot's invite URL is #{bot.invite_url(permission_bits: 526_133_873_728)}"
    # puts "Click on it to invite it to your server."
    puts "Your bot is running!"
    puts "Ctrl+C followed by `quit` to exit"

    matchers = [CoinFlipper]

    matchers.each { |matcher| matcher.register_bot_events(bot) }

    bot.run
  end
end
