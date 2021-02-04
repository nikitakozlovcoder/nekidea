class Duty < ApplicationRecord
  has_and_belongs_to_many :users
  validates :name, uniqueness: true
  def uniq_users
    users.distinct
  end
end
