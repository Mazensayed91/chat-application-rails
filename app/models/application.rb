class Application < ApplicationRecord
  has_many :chats, dependent: :destroy, foreign_key: 'application_id', primary_key: 'id'
end
