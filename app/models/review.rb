# frozen_string_literal: true

class Review < ApplicationRecord
  include AASM

  belongs_to :book
  belongs_to :user

  validates :title, :text,
            presence: true,
            format: { with: %r{\A[a-zA-Z0-9 !#\$%&'\*\+-=/\?\^\_`\{\}\|~\.]+\z},
                      message: I18n.t('models.review.title_symbols') }
  validates :title, length: { maximum: 79 }
  validates :text, length: { maximum: 499 }

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
    self.where('status = ?', 'unprocessed')
  }

  scope :processed, lambda {
    self.where('status = ? OR status = ?', 'approved', 'rejected')
  }
end
