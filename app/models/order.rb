class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :order_date, presence: true
end
