require 'rails_helper'

RSpec.describe "books/index", type: :view do
  before(:each) do
    assign(:books, [
      Book.create!(
        :title => "Title",
        :description => "MyText",
        :price => "9.99",
        :image_url => "Image Url",
        :publication_year => 2,
        :dimensions => "Dimensions",
        :materials => "Materials"
      ),
      Book.create!(
        :title => "Title",
        :description => "MyText",
        :price => "9.99",
        :image_url => "Image Url",
        :publication_year => 2,
        :dimensions => "Dimensions",
        :materials => "Materials"
      )
    ])
  end

  it "renders a list of books" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Image Url".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Dimensions".to_s, :count => 2
    assert_select "tr>td", :text => "Materials".to_s, :count => 2
  end
end
