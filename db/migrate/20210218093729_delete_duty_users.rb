class DeleteDutyUsers < ActiveRecord::Migration[6.0]
  def change
    drop_table :duty_users
  end
end
