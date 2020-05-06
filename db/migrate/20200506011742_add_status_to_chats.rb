class AddStatusToChats < ActiveRecord::Migration[6.0]
  def change
    add_column :chats, :accepted, :boolean, default: false
  end
end
