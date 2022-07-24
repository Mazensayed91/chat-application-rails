class UpdateMessagesCountJob < ApplicationJob
  queue_as :default

  def perform(token, chat_num)
    application = Application.where(token: token)
    chats = application[0].chats
    chat = chats.where(chat_num: chat_num)
    chat.update(messages_count: chat[0].messages_count + 1)
  end
end
