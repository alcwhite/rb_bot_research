# frozen_string_literal: true

require "discordrb"

module RbBotResearch
  class Components
    class << self
      def register_bot_events(bot)
        bot.message(contains: /(ct)/) { |event| send_messages(bot, event) }

        bot.string_select do |event|
          event.channel.send_message(
            "**[STRING_SELECT]**\nYou have chosen the values: **#{event.values.join('**, **')} for selection #{event.custom_id}**", false, nil, nil, nil, nil, nil
          )
          event.interaction.respond(content: "Value selected", ephemeral: true)
        end
      end

      def send_messages(bot, event)
        # event.channel.send_message("HI THERE text", false, nil, nil, nil, nil,
        #   Discordrb::Webhooks::Modal.new do |builder|
        #     builder.row do |r|
        #       r.text_input(style: 2, custom_id: "description", label: "Write your description", min_length: 10, max_length: 1000, required: true)
        #     end
        #   end
        # )

        event.channel.send_message("HI THERE", false, nil, nil, nil, nil,
          Discordrb::Webhooks::View.new do |builder|
            builder.row do |r|
              # r.text_input(style: 2, custom_id: "description", label: "Write your description", min_length: 10, max_length: 1000, required: true)
              r.string_select(custom_id: 'string_select', placeholder: 'Test of StringSelect', max_values: 1, min_values: 1) do |ss|
                        ss.option(label: 'Value 1', value: '1', description: 'First value', emoji: { name: '1️⃣' })
                        ss.option(label: 'Value 2', value: '2', description: 'Second value', emoji: { name: '2️⃣' })
                        ss.option(label: 'Value 3', value: '3', description: 'Third value', emoji: { name: '3️⃣' })
                        ss.option(label: 'Value 4', value: '4', description: 'Fourth value', emoji: { name: '4️⃣' })
                        ss.option(label: 'Value 5', value: '5', description: 'Fifth value', emoji: { name: '5️⃣' })
                        ss.option(label: 'Value 6', value: '6', description: 'Sixth value', emoji: { name: '6️⃣' })
                        ss.option(label: 'Value 7', value: '7', description: 'Seventh value', emoji: { name: '7️⃣' })
                        ss.option(label: 'Value 8', value: '8', description: 'Eighth value', emoji: { name: '8️⃣' })
                        ss.option(label: 'Value 9', value: '9', description: 'Ninth value', emoji: { name: '9️⃣' })
                        ss.option(label: 'Value 10', value: '10', description: 'Tenth value', emoji: { name: '🔟' })
                      end
            end
          end
        )

        event.channel.send_message("HI THERE #2", false, nil, nil, nil, nil,
          Discordrb::Webhooks::View.new do |builder|
            builder.row do |r|
              r.string_select(custom_id: 'string_select_2', placeholder: 'Test of StringSelect2', max_values: 1, min_values: 1) do |ss|
                        ss.option(label: 'Value 1', value: '1', description: 'First value', emoji: { name: '1️⃣' })
                        ss.option(label: 'Value 2', value: '2', description: 'Second value', emoji: { name: '2️⃣' })
                        ss.option(label: 'Value 3', value: '3', description: 'Third value', emoji: { name: '3️⃣' })
                        ss.option(label: 'Value 4', value: '4', description: 'Fourth value', emoji: { name: '4️⃣' })
                        ss.option(label: 'Value 5', value: '5', description: 'Fifth value', emoji: { name: '5️⃣' })
                        ss.option(label: 'Value 6', value: '6', description: 'Sixth value', emoji: { name: '6️⃣' })
                        ss.option(label: 'Value 7', value: '7', description: 'Seventh value', emoji: { name: '7️⃣' })
                        ss.option(label: 'Value 8', value: '8', description: 'Eighth value', emoji: { name: '8️⃣' })
                        ss.option(label: 'Value 9', value: '9', description: 'Ninth value', emoji: { name: '9️⃣' })
                        ss.option(label: 'Value 10', value: '10', description: 'Tenth value', emoji: { name: '🔟' })
                      end
            end
          end
        )
      end
    end
  end
end