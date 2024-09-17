class CreateReads < ActiveRecord::Migration[7.1]
  def change
    create_table :reads do |t|
      t.references :member, null: false, foreign_key: true
      t.references :chat, null: false, foreign_key: true
      t.integer :displayed

      t.timestamps
    end
  end
end
