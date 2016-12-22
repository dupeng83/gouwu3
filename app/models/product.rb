class Product < ApplicationRecord
  has_many :carts
  
  validates :name, presence: true
  validates :price, numericality: true
end
