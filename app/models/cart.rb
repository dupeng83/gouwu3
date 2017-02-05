class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :amount, numericality: { only_integer: true, greater_than: 0 }
end
