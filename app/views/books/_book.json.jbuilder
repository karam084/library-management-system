json.extract! book, :id, :isbn, :title, :authors, :language, :published, :edition, :cover, :subject, :summary, :category, :special_collection, :library_id, :created_at, :updated_at
json.url book_url(book, format: :json)
