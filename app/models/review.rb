# frozen_string_literal: true

class Review < ApplicationRecord
  include AASM

  belongs_to :book
  belongs_to :user

  has_rich_text :content

  validates :title,
            presence: true,
            length: { maximum: 79 },
            format: { with: %r{\A[a-zA-Z0-9 !#\$%&'\*\+-=/\?\^\_`\{\}\|~\.]+\z},
                      message: I18n.t('models.review.title_symbols') }

  validates :content, presence: true, length: { maximum: 1000 }

  aasm column: 'status' do
    state :unprocessed, initial: true
    state :approved, :rejected

    event :approve do
      transitions from: :unprocessed, to: :approved
    end

    event :reject do
      transitions from: :unprocessed, to: :rejected
    end
  end

  scope :new_, lambda {
    where('status = ?', 'unprocessed')
  }

  scope :processed, lambda {
    where('status = ? OR status = ?', 'approved', 'rejected')
  }
end
