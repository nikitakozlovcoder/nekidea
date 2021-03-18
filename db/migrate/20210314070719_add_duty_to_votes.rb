class AddDutyToVotes < ActiveRecord::Migration[6.0]
  def change
    add_column :votes, :duty_id , :bigint
  end
end
