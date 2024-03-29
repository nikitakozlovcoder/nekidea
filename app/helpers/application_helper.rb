module ApplicationHelper
  def main_photo_for obj
      if obj.pictures.first != nil
        obj.pictures.first
      else
        "/img/default_idea.svg"
      end

  end
  def idea_status idea
    case idea.idea_status
    when "active"
      "Активна"
    when "accepted"
      "Принята"
    when "archived"
      "Архивирована"
    end
  end
  #returns 'active' if current url
  def back_text(txt, back)
    return back if txt.blank?
    txt
  end
  def set_active_if path
    'active' if current_page? path
  end
  def should_show_archived_idea? idea, vote
    return false if idea.archived_on == vote.iteration+1
    true

  end
  #full user name or name exclude some fields (see source)
  def user_name(user, options = nil)
    if user != nil
      if options == nil
        [user.surname, user.name,user.patronymic].join ' '
      else
        arr = []
        arr << user.surname unless options[:surname] == false
        arr << user.name unless options[:name] == false
        arr << user.patronymic unless options[:patronymic] == false
        arr.join ' '
      end

    else
      'Пользователь удален'
    end
  end
  #full current_user name or name exclude some fields (see source)
  def current_user_name(options = nil)
    user_name current_user, options
  end
  #url to user avatar or placeholder
  def user_avatar user
    if user != nil and user.avatar.attached?
      user.avatar
    else
      "https://w3schoolsrus.github.io/w3images/avatar2.png"
    end
  end
  #url to current_user avatar or placeholder
  def current_user_avatar
    user_avatar current_user
  end
  #shows user role or nil
  def user_role user
    return nil if user.nil?
    return "Администратор" if user.is_admin
    return "Руководитель" if user.is_boss
    "Сотрудник"
  end
  #shows current vote type
  def vote_type vote
    if vote.iterations.count >1
      "Многоэтапная тематика"
    else
      "Одноэтапная тематика"
    end
  end
  def vote_status vote
    if vote.vote_status == 'archived'
      "В архиве"
    else
      if vote.iterations.count == 1
        "Активно"
      else
        "Находится на этапе "+vote.iteration.to_s
      end
    end
  end
  #shows current vote phase
  def vote_phase vote
    case vote.vote_status
    when "collecting"
      "Предложений"
    when "voting"
      "Голосований"
    when "archived"
      "Архива"
    end
  end
  def vote_phase_2 vote
    case vote.vote_status
    when "collecting"
      "Прием заявок"
    when "voting"
      "Голосование"
    when "archived"
      "----"
    end
  end
  #shows date when phase ends
  def phase_upto vote
    cur_iter = -1 + vote.iteration

    start_date = vote.created_at.to_date
    advance = 0
    iters = vote.iterations
    #cur_iter = -1 + vote.iterations.count if vote.vote_status == 'archived'
    (cur_iter).times do |i|
      advance += iters[i]['days_collecting'].to_i
      advance += iters[i]['days_voting'].to_i
    end

    advance += iters[cur_iter]['days_collecting'].to_i
    advance += iters[cur_iter]['days_voting'].to_i if vote.vote_status == 'voting' || vote.vote_status == 'archived'



    start_date.advance(days: advance).strftime('%d.%m.%y')

  end
  #crop text
  def less_text(txt, n)
    if txt != nil

      t = txt[0...n].strip()
      t+="..." if txt.length>n
      return t

    end
  end
  #format date to %d.%m.%y
  def format_date date, format='%d.%m.%y'
    date.strftime(format) unless date.nil?
  end
end
