# frozen_string_literal: true

module RbBotResearch
  class CoinFlipper
    class << self
      def register_bot_events(bot)
        bot.message(contains: /(flip a coin)|(coin flip)/) { |event| flip_a_coin(event) }
      end

      def flip_a_coin(event)
        value = rand(2).zero? ? :tails : :heads
        event.respond "You flipped #{value}"
      end
    end
  end
end