class Message < ApplicationRecord
  belongs_to :chat, foreign_key: 'chat_id', primary_key: 'id'

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name ['content'].join('_')
  document_type name.downcase

  settings index: { number_of_shards: 1 } do
    mapping dynamic: false do
      indexes :content, type: :text
      indexes :message_num, type: :integer
      indexes :chat_id, type: :integer
    end
  end

  def self.search(query, chat_num)
    params = {
      query: {
        bool: {
          must: [
            {
              query_string: {
                query: query,
                fields: ['content']
              }
            }
          ],
          filter: [
            {
              term: { chat_id: chat_num }
            }
          ]
        }
      }
    }

    __elasticsearch__.search(params).records
  end
end
