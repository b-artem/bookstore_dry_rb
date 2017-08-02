json.extract! book, :id, :title, :description, :price, :image_url, :publication_year, :dimensions, :materials, :created_at, :updated_at
json.url book_url(book, format: :json)
