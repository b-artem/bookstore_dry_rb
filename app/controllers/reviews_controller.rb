class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  decorates_assigned :book

  def show
  end

  def new
  end

  def edit
  end

  # def create
  #   @book = Book.find(params[:book_id])
  #   @review = Review.new(review_params)
  #   @review.book = @book
  #   @review.status = 'unprocessed'
  #   @review.user = current_user
  #   respond_to do |format|
  #     if @review.save
  #       format.html { redirect_to @review.book,
  #                     notice: 'Thanks for Review. It will be published as soon as Admin will approve it.' }
  #       format.json { render :show, status: :created, location: @review }
  #     else
  #       format.html { redirect_to @book, flash: { errors: @review.errors } }
  #       format.json { render json: @review.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
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
