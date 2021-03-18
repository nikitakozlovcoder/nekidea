class ChangeDefaultOfJsonarr < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:votes, :iter_array, '[]')
  end
end
