class Idea < ApplicationRecord
  belongs_to :user, optional: true
  validates :title, uniqueness: { scope: :vote_id,
                                 message: "Идея с таким названием уже была предложена" }
  belongs_to :vote, optional: true
  has_and_belongs_to_many :upvotes, :class_name => 'User', :join_table => 'ideas_upusers'
  has_and_belongs_to_many :downvotes, :class_name => 'User', :join_table => 'ideas_downusers'
  private :upvotes, :upvotes=, :downvotes, :downvotes=
  enum idea_status: [ :active, :archived, :accepted ]
  has_many :comments, dependent: :destroy
  has_many_attached :pictures

  def accept
    self.idea_status = 'accepted'
    self.save
  end

  def deaccept
    return if self.idea_status != 'accepted'
    if self.vote == nil
      self.idea_status = 'archived'
      self.save
      return
    end


    if self.archived_on != nil
      self.idea_status = 'archived'
      self.save
    elsif self.vote == 'archived'
      self.idea_status = 'archived'
      self.archived_on=self.vote.iteration+1
      self.save
    else
      self.idea_status = 'active'
      self.save
    end
  end

  def archivate
    self.idea_status='archived'
    self.archived_on=self.vote.iteration
    self.save
  end
  def rating
    upvotes.distinct.count - downvotes.distinct.count
  end

  def get_resources
    JSON.parse(self.resources)
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
    if idea_status != 'archived'
      upvotes.delete(user.id) if upvotes.exists?(user.id)
    end

  end

  def unvote_down user
    if idea_status != 'archived'
      downvotes.delete(user.id) if downvotes.exists?(user.id)
    end
  end

  def upvote user
    if idea_status != 'archived'
      downvotes.delete(user.id) if downvotes.exists?(user.id)
      # if !upvotes.exists?(user.id)
      # rating+=1
      # upvotes << user
      # end
      upvotes <<  user
    end

  end

  def downvote user
    if idea_status != 'archived'
      upvotes.delete(user.id) if upvotes.exists?(user.id)
      downvotes <<  user
    end
  end

  def can_be_updated? user
    (upvotes.distinct.count + downvotes.distinct.count == 0) && self.user == user && Time.now.getutc - self.created_at.getutc <= 60.minutes
  end

  def can_be_deleted? user
    ((upvotes.distinct.count + downvotes.distinct.count == 0) && self.user == user && Time.now.getutc - self.created_at.getutc <= 60.minutes) || user.is_admin == true
  end



end
