class CartsController < ApplicationController
	before_action :authenticate_user!
	
	def index
		#Cart.where('user_id = ?', current_user.id)
		@line_items = current_user.carts
	end

	def create
		@cart = Cart.new(cart_params)
		@cart.user_id = current_user.id
		@cart.add_or_update #method defined to determine whether to create a new record or update an existing record
		redirect_to carts_path, notice: "Successfully added to cart"
	end

	def update
		@cart = Cart.find(params[:id])
		if @cart.update_attributes(cart_params)
			redirect_to :back, notice: "Successfully updated the cart"
		end
	end
	

	def destroy
		@line_item = Cart.find(params[:id])
		@line_item.destroy
		redirect_to :back, notice: "Removed the product from the cart"

	end

	private

	def cart_params
		params[:cart].permit(:product_id, :quantity)
	end

end

