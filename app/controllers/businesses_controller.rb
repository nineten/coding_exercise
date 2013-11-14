class BusinessesController < ApplicationController
	def index
		redirect_to root_path
	end

	def new
		@title = "New Business"
	end
end
