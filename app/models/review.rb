class Review < ApplicationRecord
  include AASM

  belongs_to :book
  belongs_to :user

  validates :title, :text,
            presence: true,
            format: { with: /\A[a-zA-Z0-9 !#\$%&'\*\+-=\/\?\^\_`\{\}\|~\.]+\z/,
            # format: { with: /\A[a-zA-Z0-9{}#{Regexp.escape(!#$%&'*+-=/?^_`|~.)}]+\z/,
                      message: "only allows letters, numbers or !#$%&'*+-/=?^_`{|}~." }
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

  scope :new_, -> do
    Review.where('status = ?', 'unprocessed')
  end

  scope :processed, -> do
    Review.where('status = ? OR status = ?', 'approved', 'rejected')
  end
end
