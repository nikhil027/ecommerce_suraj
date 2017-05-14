class Product < ActiveRecord::Base
#validates :name, presence :true
	has_many :carts
	has_many :order_line_items
	has_many :reviews
	belongs_to :category


validates_presence_of :category_id, :name, :price, :stock
validates_numericality_of :price, greater_than: 1
validates_numericality_of :stock, greater_than_or_equal_to: 0

mount_uploader :cover, CoverUploader

end
