# frozen_string_literal: true

require "discordrb"

module RbBotResearch
  class Components
    class << self
      def register_bot_events(bot)
        bot.message(contains: /(test)/) { |event| send_messages(bot, event) }

        bot.string_select do |event|
          @selections[event.channel.id][event.custom_id] = event.values.join("")
          event.interaction.respond(content: "#{event.custom_id}: **#{event.values.join('')}**")
        end

        bot.button do |event|
          if event.custom_id == "description_button"
            event.show_modal(title: 'Test modal', custom_id: 'test1234') do |modal|
              modal.row do |r|
                  r.text_input(style: 2, custom_id: "description", label: "Write your description", min_length: 10, max_length: 1000, required: true)
              end
            end
            event.interaction.respond()
          elsif event.custom_id == "submit"
            if@selections[event.channel.id].length != 2
              event.channel.send_message("Please select both values first")
            elsif @text[event.channel.id].nil?
              event.channel.send_message("Please enter a description")
            elsif @submitted[event.channel.id]
              event.channel.send_message("You have already submitted this form")
            else
              @submitted[event.channel.id] = true
              event.respond(content: "Thanks for submitting your form.\n\n\nDescription: **#{@text[event.channel.id]}**\n\nSelections:\n#{@selections[event.channel.id].map { |k, v| "#{k}: **#{v}**" }.join("\n")}")
            end
          end
        end

        bot.modal_submit custom_id: 'test1234' do |event|
          @text[event.channel.id] = event.value('description')
          event.respond(content: "Description: **#{event.value('description')}**")
        end
      end

      def send_messages(bot, event)
        @selections ||= {}
        @selections[event.channel.id] = {}
        @text ||= {}
        @text[event.channel.id] = nil
        @submitted ||= {}
        @submitted[event.channel.id] = false
        event.channel.send_message("HERE'S YOUR FORM", false, nil, nil, nil, nil,
          Discordrb::Webhooks::View.new do |builder|
            builder.row do |r|
              r.string_select(custom_id: 'string_select', placeholder: 'Test of StringSelect', max_values: 1, min_values: 1) do |ss|
                        ss.option(label: '1', value: '1', description: 'Awful')
                        ss.option(label: '2', value: '2', description: 'Bad')
                        ss.option(label: '3', value: '3', description: 'Not very good')
                        ss.option(label: '4', value: '4', description: 'Not great')
                        ss.option(label: '5', value: '5', description: 'Okay')
                        ss.option(label: '6', value: '6', description: 'Good')
                        ss.option(label: '7', value: '7', description: 'Pretty good')
                        ss.option(label: '8', value: '8', description: 'Really good')
                        ss.option(label: '9', value: '9', description: 'Great')
                        ss.option(label: '10', value: '10', description: 'Perfect')
                      end
            end
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
            builder.row do |r|
              r.button(custom_id: "description_button", style: 1, label: "Add description")
            end

            builder.row do |r|
              r.button(custom_id: "submit", style: 3, label: "Submit")
            end
          end
        )
      end
    end
  end
end