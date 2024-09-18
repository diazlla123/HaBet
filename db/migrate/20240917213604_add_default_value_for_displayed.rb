class AddDefaultValueForDisplayed < ActiveRecord::Migration[7.1]
  def change
    change_column_default :reads, :displayed, 0
  end
end
