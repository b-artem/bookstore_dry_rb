class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :destroy]
  decorates_assigned :book

  def show
  end

  def new
  end

  def create
    @book = Book.find(params[:book_id])
    @review = Review.new(review_params)
    @review.book = @book
    @review.status = 'unprocessed'
    @review.user = current_user
    respond_to do |format|
      if @review.save
        format.html { redirect_to @review.book,
                      notice: t('.success') }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { redirect_to @book, flash: { errors: @review.errors } }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :text, :score, :status)
  end
end
