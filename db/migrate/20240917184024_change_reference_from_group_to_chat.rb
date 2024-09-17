class ChangeReferenceFromGroupToChat < ActiveRecord::Migration[7.1]
  def change
    remove_reference :messages, :group, foreign_key: true
    add_reference :messages, :chat, foreign_key: true
  end
end
