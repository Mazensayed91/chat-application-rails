class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.bigint :message_num
      t.text :content
      t.bigint :chat_id
      t.timestamps
    end
    add_index :messages, :message_number
    add_foreign_key :messages, :chats, on_delete: :cascade
  end
end
