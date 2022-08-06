class CreateMessageJob < ApplicationJob
  queue_as :default

  def perform(chat, current_message_number, content)
    message = chat.messages.create({ message_num: current_message_number, content: content })
    message.save
  end
end
