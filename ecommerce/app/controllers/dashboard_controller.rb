class DashboardController < ApplicationController
	before_action :check_is_admin

	def index
		@categories = Category.all 
	end
    
    def customer
    	@users = User.all
    end

    def order
    	@orders = Order.all 
    end 
end

