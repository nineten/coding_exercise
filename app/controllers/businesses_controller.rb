class BusinessesController < ApplicationController
	def index
		redirect_to root_path
	end

	def new
		@title = "New Business"
		@business = Business.new
	end

	def create	
		@business = Business.new(params[:business].permit(:name, :fb_url, :description, :submitter_name, :submitter_email))
		if @business.save
			redirect_to root_path
		else
			flash[:error] = @business.errors.empty? ? "Error" : @business.errors.full_messages.to_sentence
			render "new"
		end
	end

end
