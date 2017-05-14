class OrdersController < ApplicationController
	
	def index
		@orders = current_user.orders
	end

	def create
		@order = Order.new
		@order.order_number = "DCT-#{Random.rand(500..1000)}"
		@order.order_datetime = Date.today
		@order.user_id = current_user.id
		@order.save
		redirect_to orders_path, notice: "Thank you for placing an order with us"
	end

end
