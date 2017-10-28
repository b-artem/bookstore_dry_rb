class LineItemsController < ApplicationController
  load_and_authorize_resource only: [:update, :destroy]
  authorize_resource only: :create

  def create
    book = Book.find(params[:book_id])
    @line_item = @cart.add_product(book, params[:quantity])
    respond_to do |format|
      if @line_item.save
        format.html { redirect_back fallback_location: root_path,
                      notice: t('.success') }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { redirect_back fallback_location: root_path, alert: t('.fail') }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  rescue
    redirect_back fallback_location: root_path,
                  alert: t('.enter_positive_integer')
  end

  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: t('.success') }
        format.json { render :show, status: :ok, location: @line_item }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
        format.js { redirect_to @cart }
      end
    end
  end

  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to @cart, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private

    def line_item_params
      params.require(:line_item).permit(:quantity)
    end
end
