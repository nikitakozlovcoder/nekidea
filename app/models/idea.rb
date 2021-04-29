class Idea < ApplicationRecord
  belongs_to :user, optional: true
  validates :title, uniqueness: { scope: :vote_id,
                                 message: "Идея с таким названием уже была предложена" }
  belongs_to :vote
  has_and_belongs_to_many :upvotes, :class_name => 'User', :join_table => 'ideas_upusers'
  has_and_belongs_to_many :downvotes, :class_name => 'User', :join_table => 'ideas_downusers'
  private :upvotes, :upvotes=, :downvotes, :downvotes=
  enum idea_status: [ :active, :archived, :accepted ]


  def rating
    upvotes.distinct.count - downvotes.distinct.count
  end

  def user_action user
    if upvotes.exists?(user.id)
      :upvote
    elsif downvotes.exists?(user.id)
      :downvote
    else
      :neutral
    end
  end

  def unvote_up user
    upvotes.delete(user.id) if upvotes.exists?(user.id)
  end

  def unvote_down user
    downvotes.delete(user.id) if downvotes.exists?(user.id)
  end

  def upvote user
    downvotes.delete(user.id) if downvotes.exists?(user.id)
    # if !upvotes.exists?(user.id)
    # rating+=1
    # upvotes << user
    # end
    upvotes <<  user

  end

  def downvote user
    upvotes.delete(user.id) if upvotes.exists?(user.id)
    downvotes <<  user
  end



end
