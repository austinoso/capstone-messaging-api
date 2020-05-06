class AddStatusToChats < ActiveRecord::Migration[6.0]
  def change
    add_column :chats, :accetped, :boolean, default: false
  end
end
