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
	end

	def edit
		@sponsoredpost = Sponsoredpost.find(params[:id])
	end

	def update
		@sponsoredpost = Sponsoredpost.find(params[:id])

		@sponsoredpost.title = params[:sponsoredpost][:title]
		@sponsoredpost.body = params[:sponsoredpost][:body]
		@sponsoredpost.price = params[:sponsoredpost][:price]

		if @sponsoredpost.save
			flash[:notice] = "Sponsored post was updated."
			redirect_to @sponsoredpost
		else
			flash[:error] = "Error saving topic. Please try again."
			render :edit
		end
	end

	def destroy
		@sponsoredpost = Sponsoredpost.find(params[:id])

		if @sponsoredpost.destroy
			flash[:notice] = "\"#{@sponsoredpost.title}\" was deleted successfully."
			redirect_to action: :index
		else
			flash[:error] = "There was an error deleting the sponsoredpost."
			render :show
		end
	end
end
