class AllowNullUserIdInVotes < ActiveRecord::Migration[6.0]
  def change
    change_column :votes, :user_id, :bigint, null: true
  end
end
