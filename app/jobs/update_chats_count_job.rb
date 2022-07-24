class UpdateChatsCountJob < ApplicationJob
  queue_as :default

  def perform(token)
    application = Application.where(token: token)
    application.update(chats_count: application[0].chats_count + 1)
  end
end
