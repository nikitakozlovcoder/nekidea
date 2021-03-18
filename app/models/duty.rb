class Duty < ApplicationRecord
  has_many :duties_users, class_name: "DutyUser", dependent: :destroy
  has_many :users, through: :duties_users, class_name: "User"
  has_many :votes
  has_many :duties_users_with_write_access, -> { where has_write_access: true }, class_name: "DutyUser"
  has_many :has_write_access, through: :duties_users_with_write_access, class_name: "User", :source => :user
  validates :name, uniqueness: true
  def uniq_users
    users.distinct
  end
  #def has_write_access
   # Duty.first.duties_users.find_all{|m| m.has_write_access}.map{|m| m.user}
  #end
end
