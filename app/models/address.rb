class Address < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :addr, presence: true
end
