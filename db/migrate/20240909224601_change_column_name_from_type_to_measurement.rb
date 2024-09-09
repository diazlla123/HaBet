class ChangeColumnNameFromTypeToMeasurement < ActiveRecord::Migration[7.1]
  def change
    rename_column :tasks, :type, :unit
  end
end
