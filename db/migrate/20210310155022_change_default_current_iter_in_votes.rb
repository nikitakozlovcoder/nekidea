class ChangeDefaultCurrentIterInVotes < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:votes, :vote_status, 0)
    change_column_default(:votes, :vote_type, 0)
  end
end
