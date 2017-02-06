class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :carts
  has_many :addresses
  has_many :orders

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end
end
