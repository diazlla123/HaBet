class CreateMemberRewards < ActiveRecord::Migration[7.1]
  def change
    create_table :member_rewards do |t|
      t.references :member, null: false, foreign_key: true
      t.references :reward, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
