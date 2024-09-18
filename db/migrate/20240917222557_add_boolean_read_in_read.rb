class AddBooleanReadInRead < ActiveRecord::Migration[7.1]
  def change
    add_column :reads, :read, :boolean, default: false
  end
end
