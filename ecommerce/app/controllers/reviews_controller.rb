class ReviewsController < ApplicationController
before_action  :authenticate_user! , only: [:create]
	def create 
		@review = Review.new(review_params)
		@review.user_id = current_user.id 
		if @review.save
			redirect_to product_path(@review.product_id)
		else
			render action: :back
		end
	end

	def destroy
		@review = Review.find(params[:id])
			if @review.destroy
				redirect_to product_path(@review.product_id)
			else
				render action: :back
			end
	end

	private

	def review_params
		params[:review].permit(:title, :body, :product_id, :rating, :user_id)
    end	

end
