class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :type
      t.float :quantity
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
