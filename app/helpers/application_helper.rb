module ApplicationHelper
  def set_active_if path
    'active' if current_page? path
  end


  def user_avatar user
    if user != nil and user.avatar.attached?
      user.avatar
    else
      "https://w3schoolsrus.github.io/w3images/avatar2.png"
    end
  end
  def current_user_name(options = nil)
    user_name current_user, options
  end

  def user_name(user, options = nil)
    if user != nil
      if options == nil
        [user.name, user.surname, user.patronymic].join ' '
      else
        arr = []
        arr << user.name unless options[:name] == false
        arr << user.surname unless options[:surname] == false
        arr << user.patronymic unless options[:patronymic] == false
        arr.join ' '
      end

    else
      'Пользователь удален'
    end
  end
  def current_user_avatar
    user_avatar current_user
  end

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
        "активно"
      else
        "Находится на этапе "+vote.iteration.to_s
      end
    end
  end
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
  def phase_upto vote
    cur_iter = -1 + vote.iteration

    start_date = vote.created_at.to_date
    advance = 0
    iters = vote.iterations
    #cur_iter = -1 + vote.iterations.count if vote.vote_status == 'archived'
    (cur_iter-1).times do |i|
      advance += iters[i]['days_collecting'].to_i
      advance += iters[i]['days_voting'].to_i
    end

    advance += iters[cur_iter]['days_collecting'].to_i
    advance += iters[cur_iter]['days_voting'].to_i if vote.vote_status == 'voting' || vote.vote_status == 'archived'



    start_date.advance(days: advance).strftime('%d.%m.%y')

  end
  def less_text(txt, n)
    if txt != nil

      t = txt[0...n].strip()
      t+="..." if txt.length>n
      return t

    end
  end
end
