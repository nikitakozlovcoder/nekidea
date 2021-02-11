class ChangeDefaultRestoreDate < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:users, :restore_date, Time.now.getutc)
  end
end
