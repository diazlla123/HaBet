class CreateProgresses < ActiveRecord::Migration[7.1]
  def change
    create_table :progresses do |t|
      t.float :completion
      t.references :task, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true

      t.timestamps
    end
  end
end
