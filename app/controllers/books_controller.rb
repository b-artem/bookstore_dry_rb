class BooksController < ApplicationController
  before_action :set_category, only: :index
  load_and_authorize_resource
  decorates_assigned :book

  def index
    if sort_condition == 'popularity'
      books = @books.where(id: Book.popular_first_ids)
    else
      books = @books.public_send(@category).order(sort_condition + ' ' + sort_direction)
    end
    @books = books.page(params[:page])
  end

  def show
  end

  private

    def set_category
      return @category = 'all' unless Book::CATEGORIES.include?(params[:category])
      @category = params[:category]
    end

    def sort_condition
      return 'popularity' if params[:sort_by] == 'popularity'
      Book.column_names.include?(params[:sort_by]) ? params[:sort_by] : 'created_at'
    end

    def sort_direction
      %w[ASC DESC].include?(params[:sort_direction]) ? params[:sort_direction] : "DESC"
    end
end
