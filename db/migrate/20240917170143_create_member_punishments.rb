class CreateMemberPunishments < ActiveRecord::Migration[7.1]
  def change
    create_table :member_punishments do |t|
      t.references :member, null: false, foreign_key: true
      t.references :punishment, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
