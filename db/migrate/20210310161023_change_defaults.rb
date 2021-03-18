class ChangeDefaults < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:votes, :iter_array, '[]')
    change_column_default(:votes, :vote_status, 0)
    change_column_default(:votes, :vote_type, 0)
    change_column_default(:votes, :current_iter, 1)
  end
end
