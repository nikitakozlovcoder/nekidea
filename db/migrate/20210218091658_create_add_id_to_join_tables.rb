class CreateAddIdToJoinTables < ActiveRecord::Migration[6.0]
  def change
    add_column :duties_users, :id , :primary_key
  end
end
