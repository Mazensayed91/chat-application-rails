class Message < ApplicationRecord
  belongs_to :chat, foreign_key: 'chat_id', primary_key: 'id'
end
