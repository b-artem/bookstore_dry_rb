require 'rails_helper'

RSpec.describe "books/show", type: :view do
  before(:each) do
    @book = assign(:book, Book.create!(
      :title => "Title",
      :description => "MyText",
      :price => "9.99",
      :image_url => "Image Url",
      :publication_year => 2,
      :dimensions => "Dimensions",
      :materials => "Materials"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Image Url/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Dimensions/)
    expect(rendered).to match(/Materials/)
  end
end
