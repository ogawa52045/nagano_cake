class Item < ApplicationRecord
  has_one_attached :image
  has_many :cart_items
  has_many :order_details
  validates :price, presence: true

end
