class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :destroy]
  before_action :set_line_item, only: [:update, :destroy]

  authorize_resource

  def create
    book = Book.find(params[:book_id])
    @line_item = @cart.add_product(book, params[:quantity])
    @line_item.price = book.price
    respond_to do |format|
      if @line_item.save
        format.html { redirect_back fallback_location: root_path,
                      notice: 'Line item was successfully added to a cart' }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { redirect_back fallback_location: root_path, alert: 'Line item was not created' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  rescue
    redirect_back fallback_location: root_path,
                  alert: 'Line item was not added. Please enter positive integer quantity'
  end

  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
        format.js { set_line_item }
      end
    end
  end

  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to @cart, notice: 'Product was successfully removed' }
      format.json { head :no_content }
    end
  end

  private

    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:product_id, :quantity)
    end
end
