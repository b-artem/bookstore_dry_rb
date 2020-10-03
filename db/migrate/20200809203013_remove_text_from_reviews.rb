# frozen_string_literal: true

class RemoveTextFromReviews < ActiveRecord::Migration[6.0]
  def change
    remove_column :reviews, :text, :text
  end
end
