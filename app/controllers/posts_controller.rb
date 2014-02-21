class PostsController < ApplicationController

	def index
		@city = City.find(params[:city_id])
		@posts = @city.posts
	end

	def new
		@post = Post.new
		@city = City.find(params[:city_id])
	end

	def create
		post = Post.new(params[:post])
		if post.save
			redirect_to city_post_path(post)
		else
			erb :new
		end
	end

	def show
	end

	def edit
	end


	def update
		post = Post.find(params[:id])
		if post.update_attributes(params[:post])
			redirect_to city_post_path
		else
			erb :edit
		end
	end

	def destroy
	end
end