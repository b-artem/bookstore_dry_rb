json.extract! book, :id, :title, :description, :price, :publication_year, :dimensions, :materials, :created_at, :updated_at
json.url book_url(book, format: :json)
