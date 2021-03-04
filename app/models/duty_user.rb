class DutyUser < ApplicationRecord
  self.table_name = "duties_users"
  belongs_to :user
  belongs_to :duty
end
