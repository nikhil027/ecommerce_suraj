class Order < ActiveRecord::Base

	belongs_to :user
	has_many :order_line_items


	before_save :update_total_for_order #call_back - before the order object is saved , the method update_total_for_order is invoked 

	after_save :copy_cart_line_items #call_back - after the order opbject is saved , the method copy_cart_line_items is invoked 

	after_save :clear_user_cart
	after_save :send_order_confirmation_notification

	def send_order_confirmation_notification
		Notification.order_confirmation(self).deliver!
	end

	def update_total_for_order
		calc_total = 0
		user = self.user #fetch the current user
		#cart_line_items = user.carts
		user.carts.each do |line_item|
			calc_total += line_item.quantity * line_item.product.price
		end
		self.total = calc_total
	end


	def copy_cart_line_items
		user = self.user #fetch the current user
		cart_line_items = user.carts #find all the products added to the user
		cart_line_items.each do |line_item| #iterate over the collection
			order_line_item = OrderLineItem.new #Instantiate a new order line item object so that we can copy values to it
			order_line_item.order_id = self.id # assign the order id to order line item object
			order_line_item.product_id = line_item.product_id #assign the product id
			order_line_item.quantity = line_item.quantity
			order_line_item.price = line_item.product.price #as there is no reference to the price in the cart object, we find the product via the association and then get the price of the object
			order_line_item.save
		end
	end

	def clear_user_cart
		user = self.user
		Cart.where('user_id = ?', user.id).delete_all
	end
end
