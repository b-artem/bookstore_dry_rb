require 'rails_helper'

RSpec.describe "books/new", type: :view do
  before(:each) do
    assign(:book, Book.new(
      :title => "MyString",
      :description => "MyText",
      :price => "9.99",
      :image_url => "MyString",
      :publication_year => 1,
      :dimensions => "MyString",
      :materials => "MyString"
    ))
  end

  it "renders new book form" do
    render

    assert_select "form[action=?][method=?]", books_path, "post" do

      assert_select "input[name=?]", "book[title]"

      assert_select "textarea[name=?]", "book[description]"

      assert_select "input[name=?]", "book[price]"

      assert_select "input[name=?]", "book[image_url]"

      assert_select "input[name=?]", "book[publication_year]"

      assert_select "input[name=?]", "book[dimensions]"

      assert_select "input[name=?]", "book[materials]"
    end
  end
end
