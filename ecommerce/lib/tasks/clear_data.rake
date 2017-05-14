task :clear_data => :environment do 
	Category.delete_all
	Product.delete_all
	Cart.delete_all
	Order.delete_all
	OrderLineItem.delete_all
end