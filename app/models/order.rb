class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address

  has_many :orderitems, dependent: :destroy

  scope :need_to_be_delivered,
    -> { where("(paid = ? OR pay_method = ?) AND posted = ?",
      true, "货到付款", false) }

  scope :delivered,
    -> { where("posted = ?", true) }

  def deliver!
    update!(posted: true)
  end
end
