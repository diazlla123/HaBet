class MovingReadsToMessages < ActiveRecord::Migration[7.1]
  def change
    remove_reference :reads, :chat, foreign_key: true
    add_reference :reads, :message, foreign_key: true
  end
end
