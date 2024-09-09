class CreatePunishments < ActiveRecord::Migration[7.1]
  def change
    create_table :punishments do |t|
      t.string :name
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
