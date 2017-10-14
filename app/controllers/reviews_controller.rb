class ReviewsController < ApplicationController
  load_and_authorize_resource :book
  load_and_authorize_resource :review, through: :book

  def create
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

    def review_params
      params.require(:review).permit(:title, :text, :score)
    end
end
