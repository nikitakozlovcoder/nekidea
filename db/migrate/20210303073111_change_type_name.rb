class ChangeTypeName < ActiveRecord::Migration[6.0]
  def change
    rename_column :votes, :type, :vote_type
    add_column :votes, :vote_status, :integer
  end
end
