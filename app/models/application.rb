class Application < ApplicationRecord
  has_many :chats, dependent: :destroy, foreign_key: 'id', primary_key: 'application_id'
end
