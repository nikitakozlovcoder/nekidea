class RemoveFk < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :votes, :users
  end
end
