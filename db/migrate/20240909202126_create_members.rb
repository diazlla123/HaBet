class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members do |t|
      t.boolean :admin
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
