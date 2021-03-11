class ChangeDefaultsInVotes < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:votes, :current_iter, 1)
  end
end
