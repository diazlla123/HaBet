class AddNameToGroups < ActiveRecord::Migration[7.1]
  def change
    add_column :groups, :name, :string, null: false
  end
end
