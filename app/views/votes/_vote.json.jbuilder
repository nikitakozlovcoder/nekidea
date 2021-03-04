json.extract! vote, :id, :user_id, :type, :body, :title, :active_to, :iter_array, :current_iter, :created_at, :updated_at
json.url vote_url(vote, format: :json)
