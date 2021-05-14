class AddKeepIdeaCountToVotes < ActiveRecord::Migration[6.0]
  def change
    add_column :votes, :keep_idea_count, :integer
  end
end
