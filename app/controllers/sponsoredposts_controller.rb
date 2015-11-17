class SponsoredpostsController < ApplicationController
	def index
		@sponsoredposts = Sponsoredpost.all
	end

	def show
		@sponsoredpost = Sponsoredpost.find(params[:id])
	end

	def new
		@sponsoredpost = Sponsoredpost.new
	end

	def create
		@sponsoredpost = Sponsoredpost.new
		@sponsoredpost.title = params[:sponsoredpost][:title]
		@sponsoredpost.body = params[:sponsoredpost][:body]
		@sponsoredpost.price = params[:sponsoredpost][:price]

		if @sponsoredpost.save
			redirect_to @sponsoredpost, notice: "sponsored post was saved successfully."
		else
			flash[:error] = "Error creating sponsored post. Please try again."
			render :new
		end

		def edit
			@sponsoredpost = Sponsoredpost.find(params[:id])
		end
	end
end
