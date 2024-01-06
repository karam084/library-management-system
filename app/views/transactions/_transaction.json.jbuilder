json.extract! transaction, :id, :isbn, :email, :checkout, :request, :bookmarks, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
