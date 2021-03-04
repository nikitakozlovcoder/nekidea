class AddIsBossToUsersAddHasWriteAcessAndWriteAllToDyties < ActiveRecord::Migration[6.0]
  def change
    add_column :duties, :write_all , :boolean, :default => true
    add_column :users, :is_boss , :boolean, :default => false
    add_column :duties_users, :has_write_access , :boolean, :default => true
  end
end
