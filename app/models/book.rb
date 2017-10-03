class Book < ApplicationRecord
  CATEGORIES = %w[mobile_development photo web_design web_development].freeze

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :categories
  has_many :images, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :price, :image_url, :publication_year,
            :dimensions, :materials, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: { case_sensitive: false }
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: I18n.t('models.book.image_format') }
  validates :publication_year, inclusion: { in: 1969..Date.today.year }

  paginates_per 12

  scope :mobile_development, -> do
    Book.joins(:categories).where('categories.name = ?', 'Mobile development')
  end

  scope :photo, -> do
    Book.joins(:categories).where('categories.name = ?', 'Photo')
  end

  scope :web_design, -> do
    Book.joins(:categories).where('categories.name = ?', 'Web design')
  end

  scope :web_development, -> do
    Book.joins(:categories).where('categories.name = ?', 'Web development')
  end

  scope :best_seller, ->(category) do
    return Book.none unless CATEGORIES.include?(category.to_s)
    return Book.public_send(category).first unless LineItem.any?
    LineItem.select("line_items.book_id, sum(quantity) as total_quantity")
      .joins(:book).merge(Book.send(category))
      .joins(:order).where(orders: { state: 'delivered' })
      .group('line_items.book_id').order('total_quantity DESC').first.book
  end

  scope :popular_first_ids, -> do
    return Book.none unless LineItem.any?
    LineItem.select("line_items.book_id, sum(quantity) as total_quantity")
      .joins(:book)
      .joins(:order).where(orders: { state: 'delivered' })
      .group('line_items.book_id').order('total_quantity DESC').map(&:book_id)
  end

  private

    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, I18n.t('models.book.referenced_by_line_items'))
        throw :abort
      end
    end
end
