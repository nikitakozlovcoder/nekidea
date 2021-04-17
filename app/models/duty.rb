class Duty < ApplicationRecord
  has_many :duties_users, class_name: "DutyUser", dependent: :destroy
  has_many :users, through: :duties_users, class_name: "User"
  has_many :votes
  has_many :duties_users_with_write_access, -> { where has_write_access: true }, class_name: "DutyUser"
  has_many :has_write_access, through: :duties_users_with_write_access, class_name: "User", :source => :user
  validates :name, uniqueness: true
  before_destroy :before_destroy_callback
  def uniq_users
    users.distinct
  end
  def destroy
    super unless self.is_general
  end
  private
  def before_destroy_callback
    main_duty = Duty.find_by(is_general: true)
    self.votes.each do |vote|
      vote.duty_id = main_duty.id
      vote.save
    end
  end
  #def has_write_access
   # Duty.first.duties_users.find_all{|m| m.has_write_access}.map{|m| m.user}
  #end
end
