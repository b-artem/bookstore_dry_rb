class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :title, :text,
            presence: true,
            format: { with: /\A[a-zA-Z0-9 !#\$%&'\*\+-=\/\?\^\_`\{\}\|~\.]+\z/,
            # format: { with: /\A[a-zA-Z0-9{}#{Regexp.escape(!#$%&'*+-=/?^_`|~.)}]+\z/,
                      message: "only allows letters, numbers or !#$%&'*+-/=?^_`{|}~." }
  validates :title, length: { maximum: 79 }
  validates :text, length: { maximum: 499 }
end
