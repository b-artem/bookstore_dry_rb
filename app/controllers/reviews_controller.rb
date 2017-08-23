class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update]
  decorates_assigned :book
  
  def show
  end

  def new
    @review = Review.new
  end

  def edit
  end

  def create
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

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

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :text, :score, :status)
  end
end
