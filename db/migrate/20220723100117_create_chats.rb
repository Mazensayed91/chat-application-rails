class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.bigint :chat_num
      t.bigint :application_id
      t.bigint :messages_count
      t.timestamps
    end

    add_index :chats, :chat_num
    change_column_default :chats, :messages_count, 0
    add_foreign_key :chats, :applications, on_delete: :cascade
  end
end
