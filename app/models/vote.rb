class Vote < ApplicationRecord
  enum vote_status: [ :collecting, :voting, :archived ]
  enum vote_type: [ :multi ]
  belongs_to :user, optional: true
  belongs_to :duty
  has_many_attached :pictures
  has_many :ideas
  def can_write user
    self.user_id == user.id or user.is_admin
  end
  def iterations
    JSON.parse self.iter_array
  end
  def update_iteration

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
          puts "!!!!!!!!!!!"
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
        update_ideas
      end

    end

  end

  def can_be_updated? user
    if self.vote_status != :archived && self.current_iter == 1 && self.user == user && Time.now.getutc - self.created_at.getutc <= 60.minutes
      return true
    end
    return false
  end
  def can_be_deleted? user
    if (self.vote_status != :archived && self.user == user && Time.now.getutc - self.created_at.getutc <= 60.minutes) || user.is_admin == true
      return true
    end
    return false
  end
  def iteration
    return self.current_iter if self.vote_status != 'archived'
    self.iterations.count if self.vote_status == 'archived'
  end
  private
  def update_ideas
    puts 'update ideas'
  end

end
