# frozen_string_literal: true

# This simple bot responds to every "Ping!" message with a "Pong!"

require 'discordrb'

# This statement creates a bot with the specified token and application ID. After this line, you can add events to the
# created bot, and eventually run it.
#
# If you don't yet have a token to put in here, you will need to create a bot account here:
#   https://discord.com/developers/applications
# If you're wondering about what redirect URIs and RPC origins, you can ignore those for now. If that doesn't satisfy
# you, look here: https://github.com/discordrb/discordrb/wiki/Redirect-URIs-and-RPC-origins
# After creating the bot, simply copy the token (*not* the OAuth2 secret) and put it into the
# respective place.
bot = Discordrb::Bot.new token: ENV.fetch("DISCORD_DEV_TOKEN"), intents: [:server_messages]
# require 'discordrb'

# bot = Discordrb::Commands::CommandBot.new token: ENV.fetch("DISCORD_DEV_TOKEN"), prefix: "/"

# Here we output the invite URL to the console so the bot account can be invited to the channel. This only has to be
# done once, afterwards, you can remove this part if you want
# puts "This bot's invite URL is #{bot.invite_url}."
# puts 'Click on it to invite it to your server.'

# This method call adds an event handler that will be called on any message that exactly contains the string "Ping!".
# The code inside it will be executed, and a "Pong!" response will be sent to the channel.
# bot.message(content: 'Ping!') do |event|
#   event.respond 'Pong!'
# end

# bot.command :random do |event, min, max|
#   rand(min.to_i .. max.to_i)
# end

# bot.command(:region, chain_usable: false, description: "Gets the region the server is stationed in.") do |event|
#   event.server.region
# end

bot.register_application_command(:team, 'Team app commands', server_id: ENV.fetch('DISCORD_SERVER_ID')) do |cmd|
  cmd.subcommand_group(:fun, 'Fun things!') do |group|
    group.subcommand('8ball', 'Shake the magic 8 ball') do |sub|
      sub.string('question', 'Ask a question to receive wisdom', required: true)
    end

    group.subcommand('java', 'What if it was java?')

    group.subcommand('calculator', 'do math!') do |sub|
      sub.integer('first', 'First number')
      sub.string('operation', 'What to do', choices: { times: '*', divided_by: '/', plus: '+', minus: '-' })
      sub.integer('second', 'Second number')
    end

    group.subcommand('button-test', 'Test a button!')
  end
end

bot.application_command(:team).group(:fun) do |group|
  group.subcommand('8ball') do |event|
    wisdom = ['Yes', 'No', 'Try Again Later'].sample
    event.respond(content: "#{event.options['question']}\n_#{wisdom}_", ephemeral: true)
  end

  group.subcommand(:java) do |event|
    javaisms = %w[Factory Builder Service Provider Instance Class Reducer Map]
    jumble = []
    [*5..10].sample.times do
      jumble << javaisms.sample
    end

    event.respond(content: jumble.join)
  end

  group.subcommand(:calculator) do |event|
    result = event.options['first'].send(event.options['operation'], event.options['second'])
    event.respond(content: result)
  end
end

# This method call has to be put at the end of your script, it is what makes the bot actually connect to Discord. If you
# leave it out (try it!) the script will simply stop and the bot will not appear online.
bot.run(true)
