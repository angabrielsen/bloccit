class SponsoredpostsController < ApplicationController
	def create
		@sponsoredpost = Sponsoredpost.new
		@sponsoredpost.title = params[:sponsoredpost][:title]
		@sponsoredpost.body = params[:sponsoredpost][:body]
		@sponsoredpost.price = params[:sponsoredpost][:price]
		@topic = Topic.find(params[:topic_id])
    	@sponsoredpost.topic = @topic

		if @sponsoredpost.save
	    	flash[:notice] = "Sponsored post was saved."
	       	redirect_to [@topic, @sponsoredpost]
	    else
	    	flash[:error] = "There was an error saving the sponsored post. Please try again."
	    	render :new
	    end
	end

	def index
		@sponsoredposts = Sponsoredpost.all
	end

	def show
		@sponsoredpost = Sponsoredpost.find(params[:id])
	end

	def new
		@topic = Topic.find(params[:topic_id])
		@sponsoredpost = Sponsoredpost.new
	end

	def edit
		@sponsoredpost = Sponsoredpost.find(params[:id])
	end

	def update
		@sponsoredpost = Sponsoredpost.find(params[:id])
		@sponsoredpost.title = params[:sponsoredpost][:title]
		@sponsoredpost.body = params[:sponsoredpost][:body]

		if @sponsoredpost.save
			flash[:notice] = "Sponsored post was updated."
			redirect_to [@sponsoredpost.topic,@sponsoredpost]
		else
			flash[:error] = "There was an error saving the sponsored post. Please try again."
			render :edit
		end
	end

	def destroy
		@sponsoredpost = Sponsoredpost.find(params[:id])

		if @sponsoredpost.destroy
			flash[:notice] = "\"#{@sponsoredpost.title}\" was deleted successfully."
			redirect_to @sponsoredpost.topic
		else
			flash[:error] = "There was an error deleting the post."
			render :show
		end
	end
end
