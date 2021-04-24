class Idea < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :vote
  has_and_belongs_to_many :upvotes, :class_name => 'User', :join_table => 'ideas_upusers'
  has_and_belongs_to_many :downvotes, :class_name => 'User', :join_table => 'ideas_downusers'
  private :upvotes, :upvotes=, :downvotes, :downvotes=



  def rating
    upvotes.distinct.count - downvotes.distinct.count
  end

  def vote_up user
    downvotes.delete(user.id) if downvotes.exists?(user.id)
    # if !upvotes.exists?(user.id)
    # rating+=1
    # upvotes << user
    # end
    upvotes <<  user

  end

  def vote_down user
    upvotes.delete(user.id) if upvotes.exists?(user.id)
    downvotes <<  user
  end



end
