class Vote < ApplicationRecord
  enum vote_status: [ :collecting, :voting, :archived ]
  enum vote_type: [ :multi, :single]
  belongs_to :user, optional: true
  validates :title, :uniqueness => {:case_sensitive => false}
  belongs_to :duty
  has_many_attached :pictures
  has_many :ideas

  def self.all_for user
    if user.id != nil

      return Vote.all if user.is_admin
      return Vote.all.where(duty_id: user.all_duties)
    else
      return nil
    end
  end
  def popularity
    pop = 0
    self.ideas.each do |i| 
      pop+=i.popularity
    end
    pop
  end
  def can_write user
    self.user_id == user.id or user.is_admin
  end
  def iterations
    JSON.parse self.iter_array
  end
  def update_iteration

    old_iter = self.iteration
    new_status = 0
    new_iter = 1
    archived = true
    arr = JSON.parse(self.iter_array)
    current_datetime = DateTime.now
    created =  self.created_at.beginning_of_day
    arr.each_with_index do |el, i|
        created = created.advance(days: el['days_collecting'].to_i)
        if current_datetime < created
          new_iter = i + 1
          new_status = 0
          archived = false
          break
        end

        created = created.advance(days: el['days_voting'].to_i)
        if current_datetime < created
          new_iter = i + 1
          new_status = 1
          archived = false
          break
        end
    end
    new_status = 2 if archived

    if self.current_iter < new_iter || read_attribute_before_type_cast(:vote_status) < new_status
      t =  self.current_iter
      self.current_iter = new_iter

      self.vote_status = new_status
      self.save
      if t != new_iter || new_status == 2
        update_ideas old_iter
      end

    end

  end
  
  
 def can_create_fresh_idea?
    self.iteration == 1 && self.vote_status == "collecting"
 end

  def can_be_updated? user
   self.vote_status != :archived && self.current_iter == 1 && self.user == user && Time.now.getutc - self.created_at.getutc <= 60.minutes
  end
  
  def can_be_deleted? user
    (self.vote_status != :archived && self.user == user && Time.now.getutc - self.created_at.getutc <= 60.minutes) || user.is_admin == true
  end
  
  def iteration
    return self.current_iter if self.vote_status != 'archived'
    self.iterations.count if self.vote_status == 'archived'
  end



  private
  #1 2
  def update_ideas old_iter
    (old_iter...self.iteration).each do |iter|
      do_update iter
    end
    do_update self.iteration, true if self.vote_status == 'archived'


  end
  def do_update iter, archived=false
    self.ideas.sort_by{|idea| -idea.rating}.drop(self.keep_idea_count.to_i).each{|idea| idea.archivate if idea.idea_status != 'accepted'}

    if archived
      self.ideas.where.not(idea_status: 'archived').each do |idea|
        idea.idea_status='archived' if idea.idea_status != 'accepted'
        idea.archived_on=iter+1
        idea.save
      end
    end
  end

end
