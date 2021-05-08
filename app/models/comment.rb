class Comment < ApplicationRecord
  belongs_to :idea
  belongs_to :user, optional: true
  def can_be_deleted? user
    user != nil and (self.user_id == user.id or user.is_admin)
  end
end
