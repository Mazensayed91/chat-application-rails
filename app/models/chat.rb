class Chat < ApplicationRecord
  belongs_to :application, foreign_key: 'application_id', primary_key: 'id'
  has_many :messages, dependent: :destroy, foreign_key: 'chat_id', primary_key: 'id'
end
