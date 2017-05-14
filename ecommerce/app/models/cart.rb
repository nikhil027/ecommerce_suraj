class Cart < ActiveRecord::Base

	belongs_to :product
	belongs_to :user

	def add_or_update
		user = self.user #the data is fetched from the user who has logged in and is passed to the user object
		user_cart_line_items = user.carts #all the products which are added to the carts are passed to the object user_cart_line_items
		if user_cart_line_items.pluck(:product_id).include? self.product_id #to check whether the product added to cart match the products present in the carts added by the user 
			line_item = user_cart_line_items.find_by_product_id(self.product_id) #the product id returned to cart is found by a method find_by where column is selected 
			line_item.update_attributes(quantity: line_item.quantity + self.quantity)#the quantity by the current user is added to the already existing quantity value
		else
			self.save
		end
	end
end
