class AddColorToMember < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :color, :string
  end
end
