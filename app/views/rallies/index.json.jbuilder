json.array!(@quizzes) do |quiz|
  json.extract! quiz, :id, :name, :microquestion_id
  json.url quiz_url(quiz, format: :json)
end
