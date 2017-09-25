class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :set_category, only: :index
  decorates_assigned :book

  authorize_resource

  def index
    @books = Book.send(@category)
                 .order(sort_column + ' ' + sort_direction)
                 .page(params[:page]).per(12)
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :description, :price, :image_url, :publication_year, :dimensions, :materials)
    end

    def set_category
      return @category = 'all' unless Book::CATEGORIES.include?(params[:category])
      @category = params[:category]
    end

    def sort_column
      Book.column_names.include?(params[:sort_by]) ? params[:sort_by] : 'created_at'
    end

    def sort_direction
      %w[ASC DESC].include?(params[:sort_direction]) ? params[:sort_direction] : "DESC"
    end
end
