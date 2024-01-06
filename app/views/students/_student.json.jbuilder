json.extract! student, :id, :email, :name, :password, :education_level, :university, :max_book_allowed, :created_at, :updated_at
json.url student_url(student, format: :json)
