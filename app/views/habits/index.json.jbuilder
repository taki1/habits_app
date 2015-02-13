json.array!(@habits) do |habit|
  json.extract! habit, :user_id, :target, :start_at, :end_at
  json.url habit_url(habit, format: :json)
end