class CreateChats < ActiveRecord::Migration[5.0]
  def change
    create_table :chats do |t|
    	t.integer :guest_id
    	t.integer :host_id
    	t.integer :amount
    	t.string :chat_session
    	t.bit :is_paid
      t.timestamps
    end
  end
end
