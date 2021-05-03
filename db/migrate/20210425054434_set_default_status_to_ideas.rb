class SetDefaultStatusToIdeas < ActiveRecord::Migration[6.0]
  def change
    rename_column :ideas, :idea_state, :idea_status
    change_column_default(:ideas, :idea_status, 0)
  end
end
