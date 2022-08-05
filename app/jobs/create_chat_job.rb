class CreateChatJob < ApplicationJob
  queue_as :default

  def perform(application, current_chat_number)
    chat = application.chats.create({chat_num: current_chat_number})
    chat.save
  end
end
